class DestroyExpiredBookingsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    Request.close_bookings
  end
end
