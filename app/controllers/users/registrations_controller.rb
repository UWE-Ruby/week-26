class Users::RegistrationsController < Devise::RegistrationsController
  def after_sign_in_path_for(resource)
    show_user_path(resource)
  end

  def after_inactive_sign_up_path_for(resource)
    confirmation_sent_user_path(resource)
  end
end
