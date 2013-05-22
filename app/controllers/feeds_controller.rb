require 'resque/server'

class FeedsController < ApplicationController
  before_filter :require_login, only: [:new, :create]

  def index
    search = Search.new(search_type: 'username', value: params[:username])
    @photo_urls = Flickr.new(search).retrieve_photos
  end

  def new
    @feed = Feed.new
    @search = @feed.searches.new
  end

  def create
    @feed = current_user.feeds.new(params[:feed])

    if @feed.save
      begin
        @feed.collect_feed_items

      rescue FlickRaw::FailedResponse, FiveHundred::ResponseError
        flash.notice = 'Invalid Feed!'
        redirect_to(new_feed_path) and return
      end

      redirect_to root_url(subdomain: @feed.subdomain)
    else
      flash.notice = "Oops! We failed to create your feed"
      redirect_to new_feed_path
    end
  end

  def show
    @feed = Feed.find_by_subdomain(request.subdomain)
    @feed_items = @feed.feed_items
  end

  def destroy
    @feed = Feed.find_by_id(params[:id])
    @feed.destroy
    redirect_to dashboard_path
  end
end
