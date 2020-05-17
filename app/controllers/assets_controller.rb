class AssetsController < ApplicationController

  before_action :ensure_authorized_user, only: [:new, :create, :destroy, :add_to_wishlist]
  before_action :phone_number_verification, only: [:new, :create, :destroy], if: :user_signed_in?
  before_action :restrict_add_to_wishlist, only: [:add_to_wishlist]

  def index
    @assets = Asset.first(10)
    if params[:search]
      @assets = search_result(params[:search])
    end
  end

  def new
    @asset = Asset.new
  end

  def create
    @asset = Asset.new(asset_params)
    @asset.user = current_user
    @asset.payment_period_days = number_of_days(@asset.payment_period)
    @location = create_location_for_asset(params[:city], params[:place], params[:pincode])
    @asset.location = @location
    @asset.event_tags = params[:event_tags].split(",")
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
    @booking = @asset.booking
  end

  def get_option_for_search_input
    #puts generate_option_for_select(params[:search]) 
    render inline: "<%= options_for_select(" + generate_option_array(params[:search]).to_s + ") %>"
  end

  def add_to_wishlist
    @wishlist = create_or_assign_wishlist
    @wished_asset = @wishlist.wished_assets.create!(asset_id: params[:asset_id])
    flash[:success] = "Added to your wishlist"
    redirect_to asset_path(params[:asset_id])
  end
  
  def wished_assets
    if current_user.wishlist
      @assets = Asset.where("id in (?)", current_user.wishlist.wished_assets.pluck(:asset_id))
    else
      @assets = Asset.none
    end
  end

  def remove_from_wishlist
    current_user.wishlist.wished_assets.find_by(asset_id: params[:asset_id]).delete
    if !current_user.wishlist.wished_assets.any?  #now use of wishlist if there is no wished_assets
      current_user.wishlist.delete
    end
    flash[:success] = "Removed from your wishlist"
    redirect_to asset_path(params[:asset_id])
  end

  def sort_assets_filter
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
    if !user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def asset_params
    params.require(:asset).permit(:name, :dimension, :description, :currency, :price, :payment_period, :address, pictures: [])
  end

  def phone_number_verification
    if !current_user.phone_verification_status
      redirect_to new_phone_verification_path
    end
  end

  def generate_option_array(input_text)
    Array.new + Asset.where("name like ?", "%#{input_text}%").pluck(:name).uniq + 
    Asset.where("event_tags like ?", "%#{input_text}%").pluck(:event_tags).flatten + 
    Location.where("place like ?", "%#{input_text}%").pluck(:place).uniq + 
    Location.where("city like ?", "%#{input_text}%").pluck(:city).uniq 
  end

  def search_result(search_text)
    Asset.joins(:location).where("assets.name like ? or assets.event_tags like ? or locations.place like ? or locations.city like ?", "%#{search_text}%", "%#{search_text}%", "%#{search_text}%", "%#{search_text}%")
  end
  
  def create_location_for_asset(city, place, pincode)
    if Location.exists?(city: city, place: place, pincode: pincode)
      Location.find_by(city: city, place: place, pincode: pincode)
    else
      Location.create!(city: city, place: place, pincode: pincode)
    end
  end

  def create_or_assign_wishlist
    return current_user.wishlist if current_user.wishlist
    current_user.create_wishlist!
  end

  def restrict_add_to_wishlist
    if current_user.id == Asset.find(params[:asset_id]).user.id
      flash[:warning] = "It's your asset"
      redirect_to asset_path(params[:asset_id])
    end
    if current_user.wishlist
      if current_user.wishlist.wished_assets.where(asset_id: params[:asset_id]).any?
        flash[:warning] = "Already in your wishlist"
        redirect_to asset_path(params[:asset_id])
      end  
    end
  end

  def number_of_days(in_words)
    return 1 if in_words == "Per Day"
    return 7 if in_words == "Per Week"
    return 30 if in_words == "Per Month"
    return 365 if in_words == "Per Annum"
  end

  def sorted_assets_by_distance(coords, distance)
    locations = Location.near(coords, distance)
    assets = Array.new
    locations.each do |location|
      assets += location.assets
    end
    assets
  end
end
