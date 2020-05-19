class UsersController < ApplicationController
  def delete_profile_picture
    current_user.profile_picture.delete if current_user.profile_picture
    flash.now[:success] = "Profile pic deleted successfully"
    render 'registrations/edit'
  end

  def assets
    redirect_to new_user_session_path; return unless user_signed_in?
    @assets = current_user.assets
  end

  def show
    @user = User.find(params[:id])
  end
end
