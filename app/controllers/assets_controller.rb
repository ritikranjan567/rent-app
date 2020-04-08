class AssetsController < ApplicationController

  before_action :ensure_authorized_user, only: [:new, :create, :destroy]
  skip_before_action :verify_authenticity_token

  def index
  end

  def new
    @asset = Asset.new
  end

  def create
    @asset = Asset.new(asset_params)
    @asset.user = current_user
    @location = Location.create!(address: "BBSR")
    @asset.location = @location
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
    params.require(:asset).permit(:name, :dimension, :description, :currency, :price, :payment_period, pictures: [])
  end
  
end
