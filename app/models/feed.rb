class Feed < ActiveRecord::Base
  attr_accessor :sources, :search_type, :value

  before_save :create_searches, on: :create

  belongs_to :user
  has_many   :searches
  has_many :feed_items

  attr_accessible :searches_attributes, :name, :subdomain, :value, :search_type, :sources

  accepts_nested_attributes_for :searches, :allow_destroy => true

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

