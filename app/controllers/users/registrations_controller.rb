class Users::RegistrationsController < Devise::RegistrationsController
skip_authorization_check
#layout 'front'
protected
  def after_sign_up_path_for(resource)
    if user_signed_in? && current_user.has_role?(:admin)
      return admin_root_path
    end
  end
end
