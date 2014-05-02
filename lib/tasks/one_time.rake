namespace :one_time do
  desc 'Backfill replies'
  task backfill_replies: :environment do
    require 'gmail'

    Gmail.connect(ENV['GOOGLE_DRIVE_EMAIL'], ENV['GOOGLE_DRIVE_PASSWORD']) do |gmail|
      ['I saw your story', 'I saw your paper'].each do |subject|
        Rails.logger.info subject
        gmail.inbox.search(subject: subject).each do |email|
          timestamp = email.message.date
          email.message.from.each do |from|
            Rails.logger.info "[#{timestamp}] #{from}"
            if (contact = Contact.by_email(from).take)
              email = contact.emails.where(method: 'first_contact').take
              email.replied! timestamp
            end
          end
        end
      end
    end
  end
end
