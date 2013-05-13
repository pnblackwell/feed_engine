class FeedsController < ApplicationController

  def index
    @photo_urls = Flickr.new(params[:username]).get_photos
  end

  def new
    @feed = Feed.new
    @feed.searches.new
  end

  def create
    @feed = Feed.new(params[:feed])
    if @feed.save
      redirect_to feed_path(@feed)
    else
      redirect_to new_feed_path, notice: "Oops!"
    end
  end

  def show
    @feed = Feed.find(params[:id])
    @feed_items = @feed.feed_items
    # @photo_urls = Flickr.new(params[:username]).get_photos
  end
end
