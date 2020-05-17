class NotificationSenderJob < ApplicationJob
  queue_as :default

  def perform(item, action)
    Notification.create!(item: item, user_id: item.send(for_user_id(action)), viewed: false, message: generate_notification_message(item, action))
  end

  private
  def generate_notification_message(item, action)
    return "There is new request from #{item.requestor.first_name} for #{item.asset.name}" if action == "create"
    return "Your request is #{item.request_status} for #{item.asset.name}" if action == "update"
  end

  def for_user_id(action)
    return "to_user_id" if action == "create"
    return "to_requestor_id" if action == "update"
  end
end
