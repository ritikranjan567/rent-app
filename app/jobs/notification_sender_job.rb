class NotificationSenderJob < ApplicationJob
  queue_as :default

  def perform(item)
    Notification.create!(item: item, user_id: item.to_user_id, viewed: false, message: generate_notification_message(item))
  end

  private
  def generate_notification_message(item)
    "There is new request from #{item.requestor.first_name} for #{item.asset.name}"
  end
end
