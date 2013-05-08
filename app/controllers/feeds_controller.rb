class FeedsController < ApplicationController

  def index
    if params[:username]
      @username = params[:username]
      @photo_urls = Flickr.new(@username).get_photos
    end
  end
end