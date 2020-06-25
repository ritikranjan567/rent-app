module AssetsHelper
  #for image crousel activity
  def active_class(index)
    return "active" if index.eql? 0
    ""
  end

  def display_avg_rating(asset)
    asset.avg_rating
  end

  def is_already_wishlisted?(asset_id)
    current_user.wished_assets.find_by(asset_id: asset_id) if user_signed_in? && current_user.wishlist
  end

  def number_of_days(in_words)
    return 1 if in_words == "Per Day"
    return 7 if in_words == "Per Week"
    return 30 if in_words == "Per Month"
    return 365 if in_words == "Per Annum"
  end
  
  def sorted_assets_by_distance(coords, distance)
    locations = Location.near(coords, distance)
    locations.inject([]) do |assets, location|
      assets += location.assets
    end
  end

  def generate_option_array(input_text)
    Array.new + Asset.where("name like ?", "%#{input_text}%").pluck(:name).uniq + 
    Asset.where("event_tags like ?", "%#{input_text}%").pluck(:event_tags).flatten.uniq + 
    Location.where("place like ?", "%#{input_text}%").pluck(:place).uniq + 
    Location.where("city like ?", "%#{input_text}%").pluck(:city).uniq 
  end

  def create_or_assign_wishlist
    return current_user.wishlist if current_user.wishlist
    current_user.create_wishlist!
  end
  
end
