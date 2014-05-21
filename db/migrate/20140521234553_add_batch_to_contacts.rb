class AddBatchToContacts < ActiveRecord::Migration
  def change
    add_reference :contacts, :batch, index: true
  end
end
