class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :email
      t.string :name
      t.integer :source

      t.timestamps
    end
  end
end
