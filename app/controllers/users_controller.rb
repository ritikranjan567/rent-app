class UsersController < ApplicationController
  def delete_profile_pic
    current_user.profile_picture.delete if current_user.profile_picture
    flash.now[:success] = "Profile pic deleted successfully"
    render 'registrations/edit'
  end

  def index_of_assets
    @assets = current_user.assets
  end

  def show
    @user = User.find(params[:id])
  end
end
