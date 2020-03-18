class Booking < ApplicationRecord
  belongs_to :user
  has_many :booked_assets, dependent: :destroy
end
