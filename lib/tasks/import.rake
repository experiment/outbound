namespace :import do
  desc 'Import neuroscience contacts'
  task neuroscience: :environment do
    require 'google_drive'

    session = GoogleDrive.login ENV['GOOGLE_DRIVE_EMAIL'],
      ENV['GOOGLE_DRIVE_PASSWORD']

    doc = session.spreadsheet_by_key('1GyEGMPjFyCI8k5oErCzts_wCl6LZXHsSCeu6IywRX0I')
    sheet = doc.worksheets.first

    sheet.rows.each_with_index do |row, i|
      # Skip header row
      next if i < 1

      term, first_name, last_name, location, in_us, topic, email, url,
        source, imported = *row

      # Skip unless in US
      next unless in_us =~ /^y/i

      # Skip unless has source and url
      next unless source.present? && url.present?

      Rails.logger.info "Importing #{email}..."

      # Create Contact
      Contact.create!(source: 'manual') do |contact|
        contact.name = "#{first_name} #{last_name}"
        contact.email = email
        contact.info = { type: 'neuroscience', source: source, url: url }
      end

      # Mark as imported
      sheet[i+1, 10] = 'Y'
      sheet.save
    end
  end
end
