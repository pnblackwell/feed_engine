class AddSearchIdToFeedItems < ActiveRecord::Migration
  def change
    add_column :feed_items, :search_id, :integer
    add_index :feed_items, :search_id
  end
end
