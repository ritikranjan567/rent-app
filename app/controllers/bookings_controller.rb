class BookingsController < ApplicationController
  
  before_action :not_owner_of_asset, only: [:new_request, :create_request]

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

  protected

  def request_params
    params.require(:request).permit(:event_name, :event_description, :event_start_date, :event_end_date)
  end

  def not_owner_of_asset
    if Asset.find(params[:asset_id]).user.id == current_user.id
      flash[:danger] = "You are the owner of this asset."
      redirect_to asset_path(params[:asset_id])
    end
  end
end
