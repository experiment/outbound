class AddInfoToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :info, :hstore, default: {}
  end
end
