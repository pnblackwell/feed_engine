class FeedsController < ApplicationController

  def index
    search = Search.new(search_type: 'username', value: params[:username])
    @photo_urls = Flickr.new(search).retrieve_photos
  end

  def new
    @feed = Feed.new
    @feed.searches.new
  end

  def create
    @feed = Feed.new(params[:feed])
    if @feed.save
      @feed.collect_feed_items
      #and start background worker looking for updates
      #
      #
      redirect_to feed_path(@feed)
    else
      redirect_to new_feed_path, notice: "Oops!"
    end
  end

  def show
    @feed = Feed.find(params[:id])
    @feed_items = @feed.feed_items
    # @photo_urls = Flickr.new(params[:username]).retrieve_photos
  end
end
