class NotificationSenderJob < ApplicationJob
  queue_as :default

  def perform(item, action)
    Notification.create!(item: item, user_id: item.send(for_user_id(action)), viewed: false, message: generate_notification_message(item, action))
  end

  private
  def generate_notification_message(item, action)
    return "There is new request from #{item.requestor.first_name} for #{item.asset.name}" if action.eql? "create"
    return "Your request is #{item.request_status} for #{item.asset.name}" if action.eql? "update"
    return "A new note has been add to the request for the #{item.request.asset.name}" if action.eql? "new_note"
    #return "Booking for the #{item.asset.name} has been cancelled" if action.eql?("booking_cancel_to_owner") || action.eql?("booking_cancel_to_requestor")
  end

  def for_user_id(action)
    return "to_user_id" if action == "create"
    return "to_requestor_id" if action.eql? "update"
    return "note_to_user_id" if action.eql? "new_note"
    return "to_requestor_id" if action.eql? "booking_cancel_to_requestor"
    #return "to_owner_id" if action.eql? "booking_cancel_to_owner"
  end
end
