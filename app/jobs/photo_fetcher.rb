class PhotoFetcher
  @queue= :photo

  def self.perform(feed_id)
    feed = Feed.find(feed_id)
    feed.collect_feed_items
  end
end
