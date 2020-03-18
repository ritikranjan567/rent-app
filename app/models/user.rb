class User < ApplicationRecord
  validates :email, uniqueness: true
  has_many :assets, dependent: :destroy
  has_one :wishlist, dependent: :destroy
  has_many :bookings, dependent: :destroy
end
