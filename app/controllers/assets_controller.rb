class AssetsController < ApplicationController

  before_action :ensure_authorized_user, only: [:new, :create, :destroy]
  before_action :phone_number_verification, only: [:new, :create, :destroy], if: :user_signed_in?

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
    @location = create_location_for_asset(params[:city], params[:place], params[:pincode])
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

  def get_option_for_search_input
    #puts generate_option_for_select(params[:search]) 
    render inline: "<%= options_for_select(" + generate_option_array(params[:search]).to_s + ") %>"
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
    Array.new + Asset.where("name like ?", "%#{input_text}%").pluck(:name) + 
    Asset.where("event_tags like ?", "%#{input_text}%").pluck(:event_tags).flatten + 
    Location.where("place like ?", "%#{input_text}%").pluck(:place) + 
    Location.where("city like ?", "%#{input_text}%").pluck(:city) 
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
end
