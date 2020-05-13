class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(notification)
    notification_count = Notification.for_user(notification.user_id)

    ActionCable.server.broadcast "notifications:#{notification.user_id}", { action: "new_notification", unseen_number: notification_count, message: notification.message }
  end
end
