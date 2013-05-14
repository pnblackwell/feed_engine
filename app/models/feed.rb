class Feed < ActiveRecord::Base
  belongs_to :user
  has_many   :searches
  has_many :feed_items

  attr_accessible :searches_attributes, :name

  accepts_nested_attributes_for :searches, :allow_destroy => true

  def collect_feed_items
      searches.each { |search| search.generate_feed_items }
      feed_items
  end
end


# FlickrSouce.new(a_feed).add_items_for_search(search)
#Feed.generate_feed_items
#Search.new(source)
  #depending on source, call up SOURCE model
#FlickrSOurce only needs to know about a feed,

#InstagramSource.new(a_feed).add_items_for_search(Search.new(type: :keyword, value: "blah"))
#can have instagram source work same way
#can add items for a search

#use bckgrnd workers with url structure you want to build backwards


#worker is adding items to a feed on behalf of a user
#send creds for system account, add another header for user
#/user/feeds
#so authing a worker instead of user

# 530 at gnip,
# 630 ruby stuff,
