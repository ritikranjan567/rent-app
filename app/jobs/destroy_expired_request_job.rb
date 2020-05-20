require 'sidekiq-scheduler'
class DestroyExpiredRequestJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Request.destroy_expired_requests
  end
end
