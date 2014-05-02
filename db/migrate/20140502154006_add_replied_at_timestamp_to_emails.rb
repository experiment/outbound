class AddRepliedAtTimestampToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :replied_at, :datetime
  end
end
