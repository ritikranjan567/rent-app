class Location < ApplicationRecord
  has_many :assets, dependent: :destroy
  validates :longitude, :latitude, presence: true
  geocoded_by :full_address
  before_validation :geocode
  
  private

  def full_address
    [city, place, pincode].compact.join(",")
  end
end
