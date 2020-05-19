class ApplicationController < ActionController::Base
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def render_404
    not_found
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :profile_picture])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :profile_picture])
  end

  def user_not_authorized
    flash[:warning] = "You are not authorized for this operation"
    redirect_back fallback_location: root_path
  end

  def not_found
    render file: 'public/404.html', status: 404
  end
end
