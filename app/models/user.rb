class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  has_many :posts

  has_many :services, :dependent => :destroy

  def self.find_for_twitter_oauth(access_token, signed_in_resource=nil)
    auth_params = AuthParamsBuilder.new(access_token, :twitter).build_params
    Service.find_twitter_user(auth_params[:uid])
  end

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    Service.find_facebook_user(data.id)
  end

  def add_service!(auth_params)
    self.services.create!(AuthParamsBuilder.service_params(auth_params))
  end

  def find_service(name)
    self.services.detect do |serv|
      serv.provider == name.to_s
    end
  end

  def twitter_account
    find_service(:twitter)
  end

  def twitter
    @twitter_user ||= begin
      provider = twitter_account
      Twitter::Client.new(:oauth_token => provider.token, :oauth_token_secret => provider.secret)
    end
  end

  alias_method :has_twitter_account?, :twitter_account

  def facebook
    @facebook_user ||= begin
      provider = facebook_account
      Koala::Facebook::GraphAPI.new(provider.token)
    end
  end

  def facebook_account
    find_service(:facebook)
  end

  alias_method :has_facebook_account?, :facebook_account



end
