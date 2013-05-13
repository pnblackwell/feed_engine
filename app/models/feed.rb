class Feed < ActiveRecord::Base
  belongs_to :user
  has_many   :searches
  has_many :feed_items

  attr_accessible :searches_attributes, :name

  accepts_nested_attributes_for :searches, :allow_destroy => true

  def generate_feed_items
      searches = Search.find_all_by_feed_id(self.id)
      searches.each do |search|
        #go out to FLICKR, get the results, create FeedItems and save to db
        photos_list = Flickr.new(search).retrieve_photos
        puts "#{photos_list.inspect}"

        # "http://farm#{photo_url['farm']}.staticflickr.com/#{photo_url['server']}/#{photo_url['id']}_#{photo_url['secret']}.jpg"
        #parse through this nasty hash, and get what we need, send to FeedItems/db
      end
  end
end
