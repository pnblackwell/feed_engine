class Feed < ActiveRecord::Base
  belongs_to :user
  has_many   :searches
  has_many :feed_items

  attr_accessible :searches_attributes, :name

  accepts_nested_attributes_for :searches, :allow_destroy => true

  def generate_feed_items
      feed_items = searches.collect do |search|
        Flickr.new(search).retrieve_photos.each do |item|
          new_feed_item = FeedItem.new(item)
          new_feed_item.feed_id = id
          new_feed_item.save
        end
      end
      feed_items
  end
end
