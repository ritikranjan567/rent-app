class AssetsController < ApplicationController

  include AssetsHelper
  before_action :ensure_authorized_user, only: [:new, :create, :destroy, :add_to_wishlist]
  before_action :phone_number_verification, only: [:new, :create, :destroy], if: :user_signed_in?
  before_action :restrict_add_to_wishlist, only: [:add_to_wishlist]

  def index
    if params[:search]
      @assets = search_result(params[:search])
    else
      @assets = Asset.latest_available
    end
  end

  def new
    @asset = Asset.new
  end

  def create
    @asset = Asset.new(asset_params)
    @asset.user = current_user
    @asset.payment_period_days = number_of_days(@asset.payment_period)
    @location = Location.find_or_create_by!(city: params[:city], place: params[:place], pincode: params[:pincode])
    @asset.location = @location
    @asset.event_tags = params[:event_tags].split(",")
    if @asset.save
      flash[:notice] = "Asset has been posted successfully."
      redirect_to asset_path(@asset)
    else
      flash[:alert] = "Unable to save"
      render 'assets/new'
    end
  end

  def show
    @asset = Asset.find(params[:id])
    @booking = @asset.booking
  end

  def get_option_for_search_input
    @options = generate_option_array(params[:search])
    render inline: '<%= options_for_select(' + @options.to_s + ') %>'
  end

  def add_to_wishlist
    @wishlist = create_or_assign_wishlist
    @wished_asset = @wishlist.wished_assets.create!(asset_id: params[:asset_id])
    flash[:success] = "Asset has been added to your wishlist"
    redirect_to asset_path(params[:asset_id])
  end
  
  def wished_assets
    if current_user.wishlist
      @assets = Asset.wished_assets_of_user(current_user.wished_assets.pluck(:asset_id))
    else
      @assets = Asset.none
    end
  end

  def remove_from_wishlist
    current_user.wished_assets.find_by(asset_id: params[:asset_id]).delete
    current_user.wishlist.delete unless current_user.wished_assets.any?  #now use of wishlist if there is no wished_assets
    flash[:success] = "Asset has been removed from your wishlist"
    redirect_to asset_path(params[:asset_id])
  end

  def sort_and_filter_assets
    if params[:sort_by] == "price"
      @assets = Asset.sort_by_price
      render partial: "assets/asset", collection: @assets
    elsif params[:sort_by] == "distance"
      @assets = sorted_assets_by_distance(params[:coordinates], params[:distance])
      render partial: "assets/asset", collection: @assets
    end
  end

  private

  def ensure_authorized_user
    redirect_to new_user_session_path unless user_signed_in?
  end

  def asset_params
    params.require(:asset).permit(:name, :dimension, :description, :currency, :price, :payment_period, :address, pictures: [])
  end

  def phone_number_verification
    redirect_to new_phone_verification_path unless current_user.phone_verification_status
  end

  def restrict_add_to_wishlist
    if current_user.id == Asset.find(params[:asset_id]).user_id
      flash[:warning] = "It's your asset"
      redirect_to asset_path(params[:asset_id])
    end
    if current_user.wishlist
      if current_user.wished_assets.find_by(asset_id: params[:asset_id])
        flash[:warning] = "Already in your wishlist"
        redirect_to asset_path(params[:asset_id])
      end  
    end
  end
  
end
