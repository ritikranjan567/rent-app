class Request < ApplicationRecord
  include Notificable
  belongs_to :asset
  has_many :notes, dependent: :destroy
  validates :event_name, presence: true, length: {minimum: 2, maximum: 50}
  validates :event_description, presence: true, length: {minimum: 20, maximum: 300}
  validates :event_start_date, :event_end_date, presence: true
  has_one :booking, dependent: :destroy
  belongs_to :requestor, class_name: "User"
  validate :event_start_date_cannot_be_before_today, :event_end_cannot_be_before_start_date
  after_create :send_new_request_notifications_to_user
  after_update :send_update_notifcations_to_user
  scope :requests_by_user, ->(user_id) { where(requestor_id: user_id)}
  
  def to_user_id
    self.asset.user_id
  end

  def to_requestor_id
    self.requestor_id
  end

  def reject_other_overlapping_requests(asset_id)
    Request.where("asset_id = ? and id != ? and event_start_date < ?", asset_id, self.id, self.event_end_date.to_s).update_all(request_status: 'rejected')
  end

  def change_status_to_pending_for_non_expired_requests(asset_id)
    Request.where("id != ? and asset_id = ? and event_start_date > ?", self.id, asset_id, Date.today.to_s).update_all(request_status: 'pending')
  end

  def event_start_date_cannot_be_before_today
    errors.add(:event_start_date, "Event start date can't be before today's date") if event_start_date < Date.today
  end
  def event_end_cannot_be_before_start_date
    errors.add(:event_end_date, "Event's end date can't be before event's start date") if event_end_date < event_start_date
  end

  def self.destroy_expired_requests
    where("(event_start_date < ? and request_status in (?,?)) or event_end_date < ?",
    Date.today.to_s, 'pending', 'rejected', Date.today.to_s).destroy_all
  end

  def self.close_bookings
    requests = where("event_end_date < ? and request_status = ?", Date.today.to_s, 'accepted').destroy_all
  end
end
