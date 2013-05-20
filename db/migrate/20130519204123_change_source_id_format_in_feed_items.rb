class ChangeSourceIdFormatInFeedItems < ActiveRecord::Migration
  def change
    change_column :feed_items, :source_id, :bigint
  end
end
