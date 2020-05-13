module Notificable
  extend ActiveSupport::Concern

  included do
    has_many :notifications, as: :item
    after_commit :send_notifications_to_users
  end

  def send_notifications_to_users
    if self.respond_to? :to_user_id
      NotificationSenderJob.perform_later(self)
    end
  end
end