class Service < ActiveRecord::Base
  AUTH_TOKEN = 'ls.auth.token'
  
  belongs_to :user
  
  attr_accessible :uid, :uname, :provider, :token, :uemail, :secret
  

  def self.find_twitter_user(twitter_id)
    user_service = Service.find(:first, :conditions => ["provider = 'twitter' AND uid = ?", twitter_id])
    user_service.try(:user)
  end

  def self.find_facebook_user(facebook_id)
    user_service = Service.find(:first, :conditions => ["provider = 'facebook' AND uid = ?", facebook_id])
    user_service.try(:user)
  end
  
  def self.access_token_key(provider)
    "#{AUTH_TOKEN}.#{provider}"
  end

end
