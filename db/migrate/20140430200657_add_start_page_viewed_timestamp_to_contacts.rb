class AddStartPageViewedTimestampToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :start_page_viewed_at, :datetime
  end
end
