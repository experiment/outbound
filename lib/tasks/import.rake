namespace :import do
  desc 'Import institution contacts from google'
  task contacts: :environment do
    google_spreadsheet_key = ENV['key']
    raise 'key must be set' unless google_spreadsheet_key

    require 'google_drive'

    session = GoogleDrive.login ENV['GOOGLE_DRIVE_EMAIL'],
      ENV['GOOGLE_DRIVE_PASSWORD']

    doc = session.spreadsheet_by_key google_spreadsheet_key
    sheet = doc.worksheets.first

    headings = nil

    sheet.rows.each_with_index do |row, i|
      if i < 1
        headings = row

        # Ensure email and name columns are present
        raise 'First column must be email' unless headings[0].downcase == 'email'
        raise 'Second column must be name' unless headings[1].downcase == 'name'

        next
      end

      contact = Contact.new(source: 'institution_manual') do |contact|
        contact.email = row[0]
        contact.name = row[1]
        contact.info = Hash[*row[2, row.length].each_with_index.map do |el, i|
          next unless el.present?

          [ headings[i + 2], el ]
        end.compact.flatten]
      end

      puts "Importing #{contact.email}..."

      if contact.save
        puts "Y"
      else
        puts "N"
      end
    end
  end
end
