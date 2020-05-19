module NotificationsHelper
  def get_path(notification)
    return show_request_bookings_path(notification.item_id) if notification.item_type.eql?("Request")
    return show_request_bookings_path(notification.item.request_id) if notification.item_type.eql?("Note")
    #return asset_path(notification.item.asset_id) if notification.item_type.eql?("Booking")
  end
end
