class UpdateEmailsMethods < ActiveRecord::Migration
  def up
    Email.where(method: 'neuroscience').update_all method: 'first_contact', version: 'phone_call'
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
