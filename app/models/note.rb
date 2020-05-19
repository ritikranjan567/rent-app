class Note < ApplicationRecord
  include Notificable
  belongs_to :request
  validates :content, presence: true
  belongs_to :user
  after_create :send_new_note_notifications_to_user
  def note_to_user_id
    if self.user_id == self.request.requestor_id
      self.request.asset.user_id
    else
      self.request.requestor_id
    end
  end
end
