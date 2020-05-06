class Booking < ApplicationRecord
  belongs_to :asset
  belongs_to :request
  belongs_to :user
end
