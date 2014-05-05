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

  desc 'backfill contacts emailed from app'
  task backfill_contacts: :environment do
    # Connect to app db
    ActiveRecord::Base.connection.execute <<-SQL
      SELECT dblink_connect('app', '#{ENV['APP_DATABASE_URL']}')
    SQL

    # Query to get contacted journal_contacts from app db
    query = <<-SQL
      SELECT * FROM dblink('app', 'SELECT name, email, contacted_at, journal_name FROM journal_contacts WHERE contacted')
        AS t1(name text, email text, contacted_at timestamp, journal_name text);
    SQL

    ActiveRecord::Base.connection.execute(query).each do |row|
      puts "[#{row['contacted_at']}]\t#{row['name']}, #{row['email']}"
      info = {
        journal: row['journal_name']
      }
      Contact.create(source: 'old_outbound',
        name: row['name'], email: row['email'], info: info)
    end
  end
end
