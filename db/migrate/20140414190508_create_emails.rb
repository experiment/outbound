class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.references :contact, index: true
      t.string :method

      t.timestamps
    end
  end
end
