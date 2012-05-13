class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    service_callback("twitter")
  end

  def facebook
    service_callback("facebook")
  end

  def failure
    session["devise.twitter_data"] = request.env["omniauth.auth"]
    redirect_to root_url
  end

  # omniauth/devise require this to support rails3 route globbing
  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

  private

  def service_callback(service_name)
    service_user = find_service_user(service_name)
    omni_config = request.env["omniauth.auth"]
    store_oauth_access_token(service_name, omni_config['credentials']['token'])

    @auth_params = AuthParamsBuilder.new(omni_config, service_name).build_params
    if current_user
      add_service(service_user, service_name)
      return
    else
      if service_user && service_user.persisted?
        authenticate_user(service_user, service_name)
        return
      else
        notice = 'You must first register for an account before linking social accounts'
        handle_and_redirect(new_user_registration_path, notice)
        return
      end
    end
    render :nothing => true
  end

  def add_service(service_user, service_name)
    service_label = service_name.capitalize
    unless service_user
      handle_and_redirect(root_url, "Your #{service_label} account linked successfully!") do
        current_user.add_service!(@auth_params)
      end and return
    end

    already_linked = service_user == current_user
    notice = already_linked ? "Your account is already linked with this #{service_label} account" : "This #{service_label} account is already linked with another account"
    handle_and_redirect(root_url, notice)
  end

  def authenticate_user(service_user, service_name)
    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => service_name.capitalize
    sign_in_and_redirect service_user, :event => :authentication
  end

  def register_user(omni_config, service_name)
    service_user = User.create_service_user(@auth_params)
    if service_user
      handle_and_redirect(edit_user_path(service_user)) do
        sign_in service_user
      end
    else
      handle_and_redirect(new_user_registration_path) do
        session["devise.#{service_name}_data"] = omni_config
      end
    end
  end

  def handle_and_redirect(path, notice=nil)
    flash[:notice] = notice if notice
    yield if block_given?
    redirect_to path
  end

  def find_service_user(service_name)
    find_method_name = "find_for_#{service_name}_oauth"
    service_user = User.send find_method_name.to_sym, request.env["omniauth.auth"], current_user
  end

  def store_oauth_access_token(provider, access_token)
    session[Service.access_token_key(provider)] = access_token
  end
end
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    service_callback("twitter")
  end

  def facebook
    service_callback("facebook")
  end

  def failure
    session["devise.twitter_data"] = request.env["omniauth.auth"]
    redirect_to root_url
  end

  # omniauth/devise require this to support rails3 route globbing
  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

  private

  def service_callback(service_name)
    service_user = find_service_user(service_name)
    omni_config = request.env["omniauth.auth"]
    store_oauth_access_token(service_name, omni_config['credentials']['token'])

    @auth_params = AuthParamsBuilder.new(omni_config, service_name).build_params
    if current_user
      add_service(service_user, service_name)
      return
    else
      if service_user && service_user.persisted?
        authenticate_user(service_user, service_name)
        return
      else
        notice = 'You must first register for an account on Lone Signal before linking social accounts'
        handle_and_redirect(new_user_registration_path, notice)
        return
      end
    end
    render :nothing => true
  end

  def add_service(service_user, service_name)
    service_label = service_name.capitalize
    unless service_user
      handle_and_redirect(root_url, "Your #{service_label} account linked successfully!") do
        current_user.add_service!(@auth_params)
      end and return
    end

    already_linked = service_user == current_user
    notice = already_linked ? "Your account is already linked with this #{service_label} account" : "This #{service_label} account is already linked with another account"
    handle_and_redirect(root_url, notice)
  end

  def authenticate_user(service_user, service_name)
    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => service_name.capitalize
    sign_in_and_redirect service_user, :event => :authentication
  end

  def register_user(omni_config, service_name)
    service_user = User.create_service_user(@auth_params)
    if service_user
      handle_and_redirect(edit_user_path(service_user)) do
        sign_in service_user
      end
    else
      handle_and_redirect(new_user_registration_path) do
        session["devise.#{service_name}_data"] = omni_config
      end
    end
  end

  def handle_and_redirect(path, notice=nil)
    flash[:notice] = notice if notice
    yield if block_given?
    redirect_to path
  end

  def find_service_user(service_name)
    find_method_name = "find_for_#{service_name}_oauth"
    service_user = User.send find_method_name.to_sym, request.env["omniauth.auth"], current_user
  end

  def store_oauth_access_token(provider, access_token)
    session[Service.access_token_key(provider)] = access_token
  end
end
