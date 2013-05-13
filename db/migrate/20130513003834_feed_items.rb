class FeedItems < ActiveRecord::Migration
  def change
    create_table :feed_items do |t|
      t.string :photo_url
      t.string :source, default: 'flickr'
      t.references :feed
    end

    add_index :feed_items, :feed_id
  end
end
