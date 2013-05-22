class FeedItem < ActiveRecord::Base
  attr_accessible :photo_url, :source_id, :source,
                  :photo_title, :owner, :feed_id, :search_id

  belongs_to :feed
  belongs_to :search

end
