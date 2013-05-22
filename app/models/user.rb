class User < ActiveRecord::Base
  attr_accessible :provider, :provider_id, :username, :email
  has_many :feeds


  def self.parse_user_info(omni_auth_hash)
    username    = omni_auth_hash['info']['nickname']
    provider    = omni_auth_hash['provider']
    provider_id = omni_auth_hash['uid']

    {username: username, provider: provider, provider_id: provider_id}
  end
end
