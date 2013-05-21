class FlickrSource

  def add_items_for(search)
    photo_list = Flickr.new(search).retrieve_photos
    create_feed_items(search.feed_id, search.id, photo_list)
  end

  def create_feed_items(feed_id, search_id, photos)
    trimmed_photos = reject_existing_photos(search_id, photos)

    trimmed_photos.each do |photo|
      new_feed_item = FeedItem.new(photo)
      new_feed_item.feed_id = feed_id
      new_feed_item.search_id = search_id
      new_feed_item.save
    end
  end

  def reject_existing_photos(search_id, photos)
    feed_items = FeedItem.where(search_id: search_id)

    item_ids = feed_items.collect {|item| item.source_id}

    photos.reject! { |photo| item_ids.include? photo[:source_id] }
    photos
  end
end
