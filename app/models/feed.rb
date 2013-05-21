class Feed < ActiveRecord::Base
  belongs_to :user
  has_many   :searches
  has_many :feed_items

  attr_accessible :searches_attributes, :name, :subdomain, :value, :search_type

  accepts_nested_attributes_for :searches, :allow_destroy => true

  def collect_feed_items
    searches.each { |search| search.generate_feed_items }
  end


  def self.create_feed(params)
    feed_params = params[:feed]
    feed = Feed.create(name: feed_params[:name], subdomain: feed_params[:subdomain])

    search_params = feed_params[:searches_attributes]["0"]
    create_feed_searches(feed, search_params, params[:source])

    feed
  end

  def self.create_feed_searches(feed, search_params, feed_sources)
    searches = feed_sources.each do |source|
      feed.searches.create(search_type:   search_params[:search_type],
                           value:         search_params[:value],
                           source:        source
                          )
    end
  end
end

