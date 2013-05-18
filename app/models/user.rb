class User < ActiveRecord::Base
  attr_accessible :provider, :provider_id, :username, :email
  has_many :feeds

end
