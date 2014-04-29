class AddJsonInfoForContacts < ActiveRecord::Migration
  def up
    add_column :contacts, :json_info, :json

    Contact.find_each do |contact|
      contact.update_attributes! json_info: case contact.source
        when 'manual'
          contact.info
        when 'filofax'
          info = contact.info
          info['paper'] = { published_at: Time.parse(info['paper']) }
          info
      end
    end
  end

  def down
    remove_column :contacts, :json_info
  end
end
