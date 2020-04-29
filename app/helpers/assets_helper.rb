module AssetsHelper
  #for image crousel activity
  def active_class(ind)
    if (ind == 0)
      "active"
    else
      ""
    end
  end

  def place_owner_profile_pic(user)
    return user.profile_picture if user.profile_picture.attached?
    "profile_img.png"
  end

  def display_avg_rating(asset)
    asset.avg_rating
  end
end
