class Feed < ActiveRecord::Base
  attr_accessor :sources, :search_type, :value

  before_save :create_searches, on: :create

  belongs_to :user
  has_many   :searches
  has_many :feed_items

  validates_presence_of :subdomain, :name
  validates_uniqueness_of :subdomain, :name
  validates :subdomain, :format => { :with => /\A[a-zA-Z]+\z/, :message => 'Please enter a valid subdomain'}

  attr_accessible :searches_attributes, :name, :subdomain, :value, :search_type, :sources

  accepts_nested_attributes_for :searches, :allow_destroy => true

  after_destroy do |feed|
    feed.feed_items.destroy
    feed.searches.destroy
  end

  def collect_feed_items
    searches.each { |search| search.generate_feed_items }
  end

  def create_searches
    (sources || []).each do |source|
      searches.build(search_type: search_type,
                      value:  value,
                      source: source)
    end
  end

end

