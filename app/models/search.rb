class Search < ActiveRecord::Base
  belongs_to :feed

  attr_accessible :search_type, :value

  def generate_feed_items
    if self.source == 'flickr'
      FlickrSource.new.add_items_for(self)
    else
      raise ArgumentError
    end

    # Flickr.new(self).retrieve_photos.each do |item|
    #   new_feed_item = FeedItem.new(item)
    #   new_feed_item.feed_id = id
    #   new_feed_item.save
    # end
  end
end
