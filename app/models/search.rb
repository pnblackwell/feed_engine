class Search < ActiveRecord::Base
  belongs_to :feed
  has_many :feed_items

  attr_accessible :search_type, :value, :source

  def generate_feed_items
    if self.source == "flickr"
      FlickrSource.new.add_items_for(self)
    else
      FiveHundred.new.add_items_for(self)
    end
  end
end
