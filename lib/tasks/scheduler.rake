desc "This task is called by the Heroku scheduler add-on"
task :update_feeds => :environment do
  puts "Updating feed..."
  Search.all.each do |search|
    puts "starting update for search #{search.id}"
    Resque.enqueue(PhotoFetcher, search.id)
  end
  puts "done."
end
