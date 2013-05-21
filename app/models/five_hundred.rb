class FiveHundred

  def add_items_for(search)
    search_type = search.search_type
    value       = search.value

    send("get_#{search_type}_photo_objects", value, search)
  end

  def get_keyword_photo_objects(value, search)
    get_photo_objects("photos/search?term=#{value}&image_size=4", search)
  end

  def get_username_photo_objects(value, search)
    get_photo_objects("photos?feature=user&username=#{value}&image_size=4", search)
  end

  def get_photo_objects(url, search)
    photo_objects = JSON.parse(F00px.get(url).body)
    reject_existing_photos(photo_objects, search)
  end

  def create_feed_items(feed_id, search_id, photo_objects)
    photo_objects["photos"].each do |photo_object|
      photo_url  = photo_object["image_url"]
      source_id  = photo_object["id"]
      photo_tile = photo_object["name"]
      owner      = photo_object["user"]["username"]

      FeedItem.create(feed_id:     feed_id,
                      search_id:   search_id,
                      photo_url:   photo_url,
                      source_id:   source_id,
                      source:      "500px",
                      photo_title: photo_tile,
                      owner:       owner, )
    end
  end

  def reject_existing_photos(photo_objects, search)
    feed_items = search.feed_items
    source_ids = feed_items.collect {|item| item.source_id}
    photo_objects.reject! {|photo| source_ids.include? photo["id"]}

    create_feed_items(search.feed_id, search.id, photo_objects)
  end
end