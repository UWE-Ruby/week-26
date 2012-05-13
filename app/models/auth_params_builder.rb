class AuthParamsBuilder
  attr_accessor :provider, :config

  def initialize(omniconfig, provider)
    @provider = provider
    @config = omniconfig
  end

  # map the returned hashes to our variables first - the hashes differs for every service
  def self.from_request(request)
    # get the full hash from omniauth
    omniconfig = request.env['omniauth.auth']

    # get the service parameter from the Rails router
    provider = request.params[:provider]

    self.new(omniconfig, provider)
  end

  def build_params
    return nil unless @config && @provider
    self.try(:send, @provider)
  end

  def facebook
    user_hash = @config.extra.raw_info
    {
      :email => user_hash.email,
      :name => user_hash.name,
      :uid => user_hash.id,
      :uname => user_hash.username,
      :provider => @provider,
      :token => @config.credentials.token
    }
  end

  def twitter
    user_hash = @config.extra.raw_info
    {
      :email => nil,
      :name => user_hash.name,
      :uid => @config.uid,
      :uname => user_hash.nickname,
      :provider => @provider,
      :secret => @config.credentials.secret,
      :token => @config.credentials.token
    }
  end

  def self.params_valid?(params)
    (params and params[:uid] and params[:provider]) ? true : false
  end

  def self.service_params(params)
    params.except(:name, :email).merge(:uemail => params[:uemail])
  end

  def self.user_params(params)
    params.except(:provider, :uname, :uid).merge(:username => params[:uname])
  end

end
