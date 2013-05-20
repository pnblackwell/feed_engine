class AddSourceIdToFeedItem < ActiveRecord::Migration
  def change
    add_column :feed_items, :source_id, :integer
  end
end
