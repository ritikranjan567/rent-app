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

  def show_validation_error(data_object, symbol)
    data_object.errors.messages[symbol][0] if data_object.errors.any?
  end

end
