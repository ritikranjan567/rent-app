module NotificationsHelper
  def get_path(notification)
    return show_request_bookings_path(notification.item_id) if notification.item_type.eql?("Request") && notification.item
    return show_request_bookings_path(notification.item.request_id) if notification.item_type.eql?("Note") && notification.item
    return asset_path(notification.item_id) if notification.item_type.eql?("Asset") && notificationt.item
    "#"
  end
end
