class FeedsController < ApplicationController

  def index
    @photo_urls = Flickr.new(params[:username]).get_photos
  end

  
end