class ReplaceInfoForContacts < ActiveRecord::Migration
  def change
    remove_column :contacts, :info

    rename_column :contacts, :json_info, :info
  end
end
