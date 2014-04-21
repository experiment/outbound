class AddVersionToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :version, :string
  end
end
