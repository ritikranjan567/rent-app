module UsersHelper
  def place_user_profile_picture(user)
    return user.profile_picture if user.profile_picture.attached?
    "profile_img.png"
  end
end
