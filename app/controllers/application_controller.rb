class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :key_convert

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone_number, :profile_picture])
  end

  def key_convert(key)
    if (flash[key].include? "success")
      "success"
    elsif (key.to_s == "notice")
      "info"
    elsif (key.to_s == "alert")
      "warning"
    end
  end
end
