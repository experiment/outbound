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
      contact = Contact.new(source: 'manual') do |contact|
        contact.name = "#{first_name} #{last_name}"
        contact.email = email
        contact.info = { type: 'neuroscience', source: source, url: url }
      end

      if contact.save
        # Mark as imported
        sheet[i+1, 10] = 'Y'
        sheet.save
      end
    end
  end

  desc 'Import ocean contacts'
  task ocean: :environment do
    require 'google_drive'

    session = GoogleDrive.login ENV['GOOGLE_DRIVE_EMAIL'],
      ENV['GOOGLE_DRIVE_PASSWORD']

    doc = session.spreadsheet_by_key('1hdb4iHnY81Br5wgF-Z1NASfZEfd-rwkD37-QgAJoPx4')
    sheet = doc.worksheets.first

    sheet.rows.each_with_index do |row, i|
      # Skip header row
      next if i < 1

      term, full_name, first_name, location, in_us, topic, email, url,
        source, imported = *row

      # Skip unless in US
      next unless in_us =~ /^y/i

      # Skip unless has source and url
      next unless source.present? && url.present?

      Rails.logger.info "Importing #{email}..."

      # Create Contact
      contact = Contact.new(source: 'manual') do |contact|
        contact.name = full_name
        contact.email = email
        contact.info = { type: 'ocean research', source: source, url: url }
      end

      if contact.save
        # Mark as imported
        sheet[i+1, 10] = 'Y'
        sheet.save
      end
    end
  end

  desc 'Import diet and health contacts'
  task diet: :environment do
    require 'google_drive'

    session = GoogleDrive.login ENV['GOOGLE_DRIVE_EMAIL'],
      ENV['GOOGLE_DRIVE_PASSWORD']

    doc = session.spreadsheet_by_key('0AqAtJXQBvy08dHlxTXVUYkN4MHo1WlJMTjBPcmNJdHc')
    sheet = doc.worksheets.first

    sheet.rows.each_with_index do |row, i|
      # Skip header row
      next if i < 1

      term, first_name, last_name, location, email, url,
        source, imported = *row

      # Skip unless in US (using email ends in .edu as proxy)
      next unless email =~ /\.edu$/i

      # Skip unless has source and url
      next unless source.present? && url.present?

      Rails.logger.info "Importing #{email}..."

      # Create Contact
      contact = Contact.new(source: 'manual') do |contact|
        contact.name = "#{first_name} #{last_name}".split.join(' ')
        contact.email = email
        contact.info = { type: 'diet and health', source: source, url: url }
      end

      if contact.save
        # Mark as imported
        sheet[i+1, 8] = 'Y'
        sheet.save
      end
    end
  end

  desc 'Import exercise contacts'
  task exercise: :environment do
    require 'google_drive'

    session = GoogleDrive.login ENV['GOOGLE_DRIVE_EMAIL'],
      ENV['GOOGLE_DRIVE_PASSWORD']

    doc = session.spreadsheet_by_key('1CXGVgBOb6RFNIiZPNnQ7J0Cd5OpAhcuEofHeB0IgCeo')
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
      contact = Contact.new(source: 'manual') do |contact|
        contact.name = "#{first_name} #{last_name}".split.join(' ')
        contact.email = email
        contact.info = { type: 'exercise research', source: source, url: url }
      end

      if contact.save
        # Mark as imported
        sheet[i+1, 10] = 'Y'
        sheet.save
      end
    end
  end
end
