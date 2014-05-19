class AddWorkflowStateTimestampsToOutboundProcesses < ActiveRecord::Migration
  def change
    add_column :outbound_processes, :workflow_state_timestamps, :json, default: {}
  end
end
