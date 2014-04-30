class AddProjectCreatedTimestampToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :project_created_at, :datetime
  end
end
