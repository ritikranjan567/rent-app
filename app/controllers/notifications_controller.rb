class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(user: current_user).unviewed.news

    respond_to do |format|
      format.html
      format.js
    end
  end

  private
  def notification_params
    params.require(:notification).permit(:viewed)
  end
end
