module Notificable
  extend ActiveSupport::Concern

  included do
    has_many :notifications, as: :item, dependent: :destroy
  end

  def send_new_request_notifications_to_user
    if self.respond_to? :to_user_id
      NotificationSenderJob.perform_later(self, "create")
    end
  end

  def send_update_notifcations_to_user
    if self.respond_to? :to_requestor_id
      NotificationSenderJob.perform_later(self, "update")
    end
  end

  def send_new_note_notifications_to_user
    if self.respond_to? :note_to_user_id
      NotificationSenderJob.perform_later(self, "new_note")
    end
  end
end