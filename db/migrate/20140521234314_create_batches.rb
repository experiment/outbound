class CreateBatches < ActiveRecord::Migration
  def change
    create_table :batches do |t|
      t.date :created_at
    end
  end
end
