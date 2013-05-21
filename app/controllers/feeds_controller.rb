require 'resque/server'

class FeedsController < ApplicationController
  before_filter :require_login, only: [:new, :create]

  def index
    @feeds =  Feed.where(:user_id => current_user.id)
  end

  def new
    @feed = Feed.new
    @search = @feed.searches.new
  end

  def create
    @feed = Feed.new(params[:feed])
    @feed.user_id = current_user.id

    if @feed.save
      # search = Search.new(params[:feed][:searches_attributes]["0"])
      # search.feed_id = @feed.id
      # search.save

      @feed.collect_feed_items

      #if i do the below, then its going to be slow for sure on first run, but what if we just
      #do an immediate call here and save teh resque for updating/adding searches

      #SETUP FOR USING RESQUE TO GET THE PHOTOS
      # search_id = @feed.searches.first.id
      # Resque.enqueue(PhotoFetcher, search_id)

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
