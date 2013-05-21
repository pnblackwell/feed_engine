class FetchingScheduler
  @queue = :schedule

  def self.perform
    Search.all.each do |search|
      Resque.enqueue(PhotoFetcher, search.id)
    end
  end
end
