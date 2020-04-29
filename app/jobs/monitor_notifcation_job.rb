class MonitorNotifcationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    if current_user.unviewed_notifications_count > 0
      NotificationBroadcastJob.perform_later(current_user.id)
  end
end
