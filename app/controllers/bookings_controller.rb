class BookingsController < ApplicationController
  
  before_action :check_user, only: [:new_request, :create_request]

  def new_request
    @request = Asset.find(params[:asset_id]).requests.build
  end

  def create_request
    @request = Asset.find(params[:asset_id]).requests.build(request_params)
    @request.user_id = current_user.id
    if @request.save
      flash[:success] = "Request is sent to the owner successfully"
      redirect_to assets_path
      #To-do notify the owner (notification system)
    else
      render 'new_request'
    end
  end

  def requests_index
    @requests = current_user.requests
  end

  def show_request
    @request = Request.find(params[:id])
  end

  protected

  def request_params
    params.require(:request).permit(:event_name, :event_description, :event_start_date, :event_end_date)
  end

  def check_user
    if (Asset.find(params[:asset_id]).user.id == current_user.id)
      flash[:danger] = "You are the owner of this asset."
      redirect_to asset_path(params[:asset_id])
    
    elsif Request.find_by(userid: current_user.id)
      flash[:danger] = "You have aleady requested for this asset."
      redirect_to asset_path(params[:asset_id])

    elsif !current_user.phone_verification_status
      flash[:warning] = "Verify your phone number to request"
      redirect_to new_phone_verification_path
    end
  end
end
