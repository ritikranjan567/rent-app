require 'sidekiq-scheduler'
class DestroyExpiredRequestJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Request.destroy_expired_requests
    Request.close_bookings
  end
end
