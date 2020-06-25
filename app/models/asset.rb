class Asset < ApplicationRecord
  serialize :event_tags
  belongs_to :user
  has_many :ratings, dependent: :destroy
  belongs_to :location
  has_many :requests, dependent: :destroy
  has_many_attached :pictures, dependent: :destroy
  has_many :bookings, dependent: :destroy

  scope :sort_by_price, -> { order("price / payment_period_days") }
  scope :latest_available, -> { order(:created_at).where(available: true) }
  scope :wished_assets_of_user, ->(asset_ids) { where("id in (?)", asset_ids) } 
  
  def avg_rating
    return self.ratings.average(:score).to_f if self.ratings.any?
    0.0
  end

  def accepted_requests
    self.requests.where(request_status: 'accepted')
  end

  def self.search(search_text)
    joins(:location).where("assets.name like ? or assets.event_tags like ? or locations.place like ? or locations.city like ?",
       "%#{search_text}%", "%#{search_text}%", "%#{search_text}%", "%#{search_text}%")
  end
end
