class Feed < ActiveRecord::Base
  belongs_to :user
  has_many   :searches
  has_many :feed_items

  attr_accessible :searches_attributes, :name, :subdomain, :value, :search_type

  accepts_nested_attributes_for :searches, :allow_destroy => true

  after_destroy do |feed|
    feed.feed_items.destroy
    feed.searches.destroy
  end
  
  def collect_feed_items
    searches.each { |search| search.generate_feed_items }
  end
end
