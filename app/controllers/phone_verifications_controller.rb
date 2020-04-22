class PhoneVerificationsController < ApplicationController
  
  #skip_before_action :phone_number_verification

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
  
end
