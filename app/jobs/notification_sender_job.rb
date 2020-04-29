class NotificationSenderJob < ApplicationJob
  queue_as :default

  def perform(item)
    Notification.create!(item: item, user_id: item.user_id, viewed: false)
  end
end
