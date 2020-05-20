class SendCancelBookingNotificationJob < ApplicationJob
  queue_as :default

  def perform(to_user_id, item, message)
    Notification.create!(item: item, user_id: to_user_id, viewed: false, message: message)
  end
end
