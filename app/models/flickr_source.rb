class FlickrSource

  def add_items_for(search)
    photos = Flickr.new(search).retrieve_photos
    create_feed_items(search.feed_id, photos)
  end

  def create_feed_items(feed_id, photos)
    photos.each do |photo|
      new_feed_item = FeedItem.new(photo)
      new_feed_item.feed_id = feed_id
      new_feed_item.save
    end
  end
end
