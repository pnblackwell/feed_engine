class SearchesController < ApplicationController

  def show
    @feed = Feed.new
    @feed.searches.new
  end

end
