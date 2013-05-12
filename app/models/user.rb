class User < ActiveRecord::Base
  has_many :feeds

  def self.from_omniauth(auth)
    where(auth.slice("provider", "provider_id")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.provider_id = auth["uid"]
      user.username = auth["info"]["nickname"]
    end
  end
end