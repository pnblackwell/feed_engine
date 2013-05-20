class PhotoFetcher
  @queue= :photo

  def self.perform(search_id)
    search = Search.find(search_id)
    search.generate_feed_items
  end
end
