  require 'resque/server'

class FeedsController < ApplicationController
  before_filter :require_login, only: [:new, :create]

  def index
    @feeds = Feed.where(:user_id => current_user.id)
    @feeds.each do |feed|
      feed.feed_items.each do |feed_item|
        @image = MiniMagick::Image.open(feed_item.photo_url)
      end
    end
    # @thumbnail = resize_and_crop(@image, size(in_px))
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
    if @feed.nil?
      flash.notice = 'Feed Does Not Exist'
      redirect_to(root_url(subdomain: false)) and return
    end
    @feed_items = @feed.feed_items
  end

  def destroy
    @feed = Feed.find_by_id(params[:id])
    @feed.destroy
    redirect_to dashboard_path
  end
end
