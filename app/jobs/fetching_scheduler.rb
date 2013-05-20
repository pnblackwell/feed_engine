class FetchingScheduler
  @queue = :schedule

  def self.perform
    resque.logger.info "Schedule all things for all the times"
    Search.all.each do |search|
      Resque.enqueue(PhotoFetcher, search.id)
    end
  end
end
