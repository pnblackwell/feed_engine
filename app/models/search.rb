class Search < ActiveRecord::Base
  belongs_to :feed
  has_many :feed_items

  attr_accessible :search_type, :value

  def generate_feed_items
    # if self.source == 'flickr'
    FlickrSource.new.add_items_for(self)
  end
end
