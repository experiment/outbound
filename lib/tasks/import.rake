namespace :import do
  desc 'Import institution contacts from google'
  task contacts: :environment do

    google_spreadsheet_key = '1uK1CD8-fHol8JruzGtJX-1H9S40p0h_3_zBie6O86QA'
    raise 'key must be set' unless google_spreadsheet_key

    require 'google_drive'

    session = GoogleDrive.login ENV['GOOGLE_DRIVE_EMAIL'],
      ENV['GOOGLE_DRIVE_PASSWORD']

    doc = session.spreadsheet_by_key google_spreadsheet_key
    sheet = doc.worksheets[2]

    headings = nil

    sheet.rows.each_with_index do |row, i|
      if i < 1
        headings = row

        # Ensure email and name columns are present
        # raise 'First column must be email' unless headings[4].downcase == 'email'
        # raise 'Second column must be name' unless headings[1].downcase == 'name'

        next
      end

      contact = Contact.new(source: 'institution_manual') do |contact|
        contact.email = row[4]
        contact.name = "#{row[5]} #{row[6]}"
        contact.info = Hash[*row.each_with_index.map do |el, i|
          next unless el.present?

          [ headings[i], el ]
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
