module AssetsHelper
  #for image crousel activity
  def active_class(ind)
    if (ind == 0)
      "active"
    else
      ""
    end
  end

  def display_avg_rating(asset)
    asset.avg_rating
  end

  def already_in_wishlist?(asset_id)
    if user_signed_in?
      if current_user.wishlist
        if current_user.wishlist.wished_assets.where(asset_id: asset_id).any?
          true
        else
          false
        end
      else
        false
      end
    end
  end
  
end
