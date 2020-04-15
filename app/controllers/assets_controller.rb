class AssetsController < ApplicationController

  before_action :ensure_authorized_user, only: [:new, :create, :destroy]

  def index
    @assets = Asset.first(20)
  end

  def new
    @asset = Asset.new
  end

  def create
    @asset = Asset.new(asset_params)
    @asset.user = current_user
    @location = Location.create!(address: params[:address], place: params[:place], pincode: params[:pincode])
    @asset.location = @location
    @asset.event_tags = params[:event_tags].split(" ")
    if @asset.save
      flash[:notice] = "Asset posted successfully."
      redirect_to asset_path(@asset)
    else
      flash[:alert] = "Unable to save"
      render 'assets/new'
    end
  end

  def show
    @asset = Asset.find(params[:id])
  end

  private

  def ensure_authorized_user
    if !user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def asset_params
    params.require(:asset).permit(:name, :dimension, :description, :currency, :price, :payment_period, :booking_type, pictures: [])
  end
  
end
