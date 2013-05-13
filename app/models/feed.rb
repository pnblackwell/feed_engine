class Feed < ActiveRecord::Base
  belongs_to :user
  has_many   :searches
  has_many :feed_items

  attr_accessible :searches_attributes, :name

  accepts_nested_attributes_for :searches, :allow_destroy => true
end
