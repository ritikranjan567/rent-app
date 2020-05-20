class PhoneVerificationsController < ApplicationController
  
  before_action :check_unique_cellId, only: [:create]
  before_action :restrict_new, only: [:new]

  def new
  end
  
  def create
    session[:phone_number] = params[:phone_number]
    session[:country_code] = params[:country_code]
    
    @response = Authy::PhoneVerification.start(
      via: params[:method],
      country_code: params[:country_code],
      phone_number: params[:phone_number]
    )

    if @response.ok?
      redirect_to challenge_phone_verifications_path
    else
      render "phone_verifications/new"
    end
  end

  def challenge
  end

  def verify
    @response = Authy::PhoneVerification.check(
      verification_code: params[:code],
      country_code: session[:country_code],
      phone_number: session[:phone_number]
    )

    if @response.ok?
      current_user.update!(phone_number: session[:phone_number], country_code: session[:country_code], phone_verification_status: true)
      session[:phone_number] = nil
      session[:country_code] = nil
      flash[:notice] = "Your phone number verified successfully."
      redirect_to root_path
    else
      render challenge
    end
  end

  private

  def check_unique_cellId
    if User.where(phone_number: params[:phone_number]).any?
      flash[:warning] = "Phone number already taken"
      redirect_to new_phone_verification_path
    end
  end
  def restrict_new
    if user_signed_in? && current_user.phone_verification_status
      flash[:warning] = "You have already verified your phone number"
      redirect_back(fallback_location: root_path)
    end
  end
end
