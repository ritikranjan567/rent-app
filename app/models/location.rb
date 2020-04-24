class Location < ApplicationRecord
  has_many :assets, dependent: :destroy
  validates :longitude, :latitude, presence: true
  geocoded_by :full_address
  before_validation :geocode, if: :place_changed?

  scope :place_like, ->(place) { where("place like ?", "%#{place}%") }
  scope :city_like, ->(city) { where("city like ?", "%#{city}%") }
  
  private

  def full_address
    [city, place, pincode].compact.join(",")
  end
end
