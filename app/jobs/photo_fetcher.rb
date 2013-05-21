require 'logger'

class PhotoFetcher
  @queue= :photo

  def self.perform(search_id)
    log.info "Search for #{search_id}"
    search = Search.find(search_id)
    search.generate_feed_items
  end

  def self.log
    @log ||= Logger.new(STDOUT)
  end
end
