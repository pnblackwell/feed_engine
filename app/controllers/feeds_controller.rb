require 'resque/server'

class FeedsController < ApplicationController

  def index
    search = Search.new(search_type: 'username', value: params[:username])
    @photo_urls = Flickr.new(search).retrieve_photos
  end

  def new
    @feed = Feed.new
    @search = @feed.searches.new
  end

  def create
    @feed = Feed.new(params[:feed])
    if @feed.save
      # @feed.collect_feed_items
      # search_id = @feed.searches.first.id
      Resque.enqueue(PhotoFetcher, @feed.id)

      redirect_to root_url(subdomain: @feed.subdomain)
    else
      redirect_to new_feed_path, notice: "Oops! We failed to create your feed"
    end
  end

  def show
    @feed = Feed.find_by_subdomain(request.subdomain)
    @feed_items = @feed.feed_items
  end
end
