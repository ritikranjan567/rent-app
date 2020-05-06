module BookingsHelper
  def get_requestor_name(user_id)
    user = User.find(user_id)
    return "Me" if user.id == current_user.id
    user.first_name + " " + user.last_name
  end
end
