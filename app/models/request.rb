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

  def to_user_id
    self.asset.user.id
  end

  def to_requestor_id
    self.requestor.id
  end

  def event_start_date_cannot_be_before_today
    errors.add(:event_start_date, "Event start date can't be before today's date") if event_start_date < Date.today
  end
  def event_end_cannot_be_before_start_date
    errors.add(:event_end_date, "Event's end date can't be before event's start date") if event_end_date < event_start_date
  end
end
