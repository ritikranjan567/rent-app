class Asset < ApplicationRecord
  serialize :event_tags
  belongs_to :user
  has_many :ratings, dependent: :destroy
  belongs_to :location
  has_many :requests, dependent: :destroy
  has_many_attached :pictures, dependent: :destroy
  has_one :booking, dependent: :destroy

  scope :sort_by_price, -> { order("price / payment_period_days") }
  scope :latest_available, -> { order(:created_at).where(available: true) }
  scope :wished_assets_of_user, ->(asset_ids) { where("id in (?)", asset_ids) } 
  def avg_rating
    if self.ratings.any?
      self.ratings.average(:score).to_f
    else
      "No reviews yet"
    end
  end

end
