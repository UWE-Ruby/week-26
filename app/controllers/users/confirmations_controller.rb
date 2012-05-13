class Users::ConfirmationsController < Devise::ConfirmationsController
  def after_sign_in_path_for(resource)
    activated_user_path(resource)
  end
end
