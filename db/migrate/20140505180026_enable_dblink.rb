class EnableDblink < ActiveRecord::Migration
  def change
    enable_extension 'dblink'
  end
end
