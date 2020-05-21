class BookingsController < ApplicationController
  
  before_action :check_user, only: [:new_request, :create_request]
  before_action unless: :user_signed_in?, only: [:index, :requested_assets, :requests] do
    redirect_to new_user_session_path
  end

  def index
    @bookings = current_user.bookings
  end

  def booked_assets
    @assets = current_user.assets.where(available: false)
  end

  def destroy
    @booking = Booking.find(params[:id])
    authorize @booking
    @asset = @booking.asset
    @asset.update(available: true)
    @booking.request.change_status_to_pending_for_non_expired_requests(@booking.asset_id)
    SendCancelBookingNotificationJob.perform_later(to_user_id(@booking.request), @asset, "Booking for #{@asset.name} cancelled by #{current_user.first_name}")
    
    if @booking.request.destroy
      flash[:success] = "Booking has been successfully cancelled"
      redirect_to asset_path(@asset)
    else
      flash[:danger] = "Unable to cancel booking"
      redirect_to asset_path(@asset)
    end
  end

  def new_request
    @request = Asset.find(params[:asset_id]).requests.build
  end

  def create_request
    @request = Asset.find(params[:asset_id]).requests.build(request_params)
    @request.requestor = current_user
    if @request.save
      flash[:success] = "Request is sent to the owner successfully"
      redirect_to assets_path
    else
      flash[:danger] = "Unable to save request!"
      render 'new_request'
    end
  end

  def requested_assets
    @assets = current_user.assets
  end

  def show_request
    @request = Request.find(params[:id])
    authorize @request, :show?
  end

  def requests
    @requests = Request.requests_by_user(current_user.id)
  end

  def reject_request
    @request = Request.find(params[:request_id])
    @request.request_status = "rejected"
    authorize @request, :update?
    if @request.save
      flash[:success] = "You have rejected the request"
      redirect_to show_request_bookings_path(params[:request_id])
    else
      flash[:danger] = "Some errors occur while making changes"
      redirect_to show_request_bookings_path(params[:request_id])
    end
  end

  def accept_request
    @request = Request.find(params[:request_id])
    authorize @request, :update?
    @asset = @request.asset
    @booking = @request.build_booking
    @booking.user = @request.requestor
    @booking.asset = @request.asset
    @asset.available = false
    @request.request_status = "accepted"
    @request.reject_other_overlapping_requests(@asset.id)
    ActiveRecord::Base.transaction do
      @request.save!
      @asset.save!
      @booking.save!
    end
    flash[:success] = "This requested is accepted"
    redirect_to show_request_bookings_path(@request)
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = "Unable accept request due to some error"
      redirect_to show_request_bookings_path(@request)
  end


  private

  def request_params
    params.require(:request).permit(:event_name, :event_description, :event_start_date, :event_end_date)
  end

  def check_user
    if !user_signed_in?
      flash[:warning] = "Sign-up/Sign-first "
      redirect_to new_user_session_path

    elsif (Asset.find(params[:asset_id]).user.id == current_user.id)
      flash[:danger] = "You are the owner of this asset."
      redirect_to asset_path(params[:asset_id])
    
    elsif Asset.find(params[:asset_id]).requests.find_by(requestor_id: current_user.id)
      flash[:danger] = "You have aleady requested for this asset."
      redirect_to asset_path(params[:asset_id])

    elsif !current_user.phone_verification_status
      flash[:warning] = "Verify your phone number to request"
      redirect_to new_phone_verification_path
    end
  end

  def to_user_id(request)
    if current_user.id.eql?(request.requestor_id)
      request.asset.user_id
    else
      request.requestor_id
    end
  end
end
