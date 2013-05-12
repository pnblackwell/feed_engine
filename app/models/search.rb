class Search < ActiveRecord::Base
  belongs_to :feed

  attr_accessible :search_type, :value
end