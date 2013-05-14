class FeedItem < ActiveRecord::Base
  attr_accessible :photo_url, :source, :photo_title, :owner
  belongs_to :feed

end
