class CreateOutboundProcesses < ActiveRecord::Migration
  def change
    create_table :outbound_processes do |t|
      t.references :contact, index: true
      t.string :workflow_state

      t.timestamps
    end
  end
end
