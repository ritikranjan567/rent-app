module ApplicationHelper

  def place_profile_picture
    return current_user.profile_picture if (current_user.profile_picture.attached?)
    "profile_img.png"
  end

end
