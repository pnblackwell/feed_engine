class AddAttributesToFeedItems < ActiveRecord::Migration
  def change
    add_column :feed_items, :photo_title, :string
    add_column :feed_items, :owner, :string
  end
end
