class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :key_convert
  #before_action :phone_number_verification, if: :user_signed_in?

  def phone_number_verification
    if !current_user.phone_verification_status
      redirect_to new_phone_verification_path
    end
  end

  protected

  def key_convert(key)
    if (flash[key].include? "success")
      "success"
    elsif (key.to_s == "notice")
      "info"
    elsif (key.to_s == "alert")
      "warning"
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :profile_picture])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :profile_picture])
  end
end
