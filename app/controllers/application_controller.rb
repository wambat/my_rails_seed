class ApplicationController < ActionController::Base
  protect_from_forgery :with :exception

  def forbidden
    raise ActionController::RoutingError.new('403 Forbidden')
  end

  def after_sign_in_path_for(resource)
    if user_signed_in? && current_user.has_role?(:admin)
      return admin_root_path
    else
      return sandbox_path
    end
  end

  def not_found
    raise ActionController::RoutingError.new('404 Not Found')
  end

  protected
  def authenticate_admin!
    redirect_to new_user_session_path unless user_signed_in? && current_user.has_role?(:admin)
  end

  private

end
