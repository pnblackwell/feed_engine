class Search < ActiveRecord::Base
  belongs_to :feed

  attr_accessible :search_type, :value

  def create_feed_items
    #use the search params, go out to the API and fetch the results,
    #turn each item into a feed item
  end
end
