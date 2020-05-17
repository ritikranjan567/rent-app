module Notificable
  extend ActiveSupport::Concern

  included do
    has_many :notifications, as: :item
    after_create :send_create_notifications_to_user
    after_update :send_update_notifcations_to_user
  end

  def send__create_notifications_to_user
    if self.respond_to? :to_user_id
      NotificationSenderJob.perform_later(self, "create")
    end
  end

  def send_update_notifcations_to_user
    if self.respond_to? :to_requestor_id
      NotificationSenderJob.perform_later(self, "update")
    end
  end
end