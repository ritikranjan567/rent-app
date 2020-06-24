module ApplicationHelper

  def key_convert(key)
    respective_val = {notice: "info", alert: "warning" }
    if (flash[key].include? "success")
      "success"
    elsif respective_val.include? key.to_sym
      respective_val[key.to_sym]
    else
      key.to_s
    end
  end

  def place_user_profile_picture(user)
    return user.profile_picture if (user.profile_picture.attached?)
    "profile_img.png"
  end

  def show_validation_error(data_object, symbol)
    data_object.errors.messages[symbol][0] if data_object.errors.any?
  end

  def get_unviewed_count
    Notification.for_user(current_user.id)
  end

end
