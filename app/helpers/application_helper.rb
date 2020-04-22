module ApplicationHelper

  def key_convert(key)
    if (flash[key].include? "success")
      "success"
    elsif (key.to_s == "notice")
      "info"
    elsif (key.to_s == "alert")
      "warning"
    end
  end

  def place_profile_picture
    return current_user.profile_picture if (current_user.profile_picture.attached?)
    "profile_img.png"
  end

end
