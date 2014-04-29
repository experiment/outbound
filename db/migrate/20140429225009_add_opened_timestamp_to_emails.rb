class AddOpenedTimestampToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :opened, :datetime
  end
end
