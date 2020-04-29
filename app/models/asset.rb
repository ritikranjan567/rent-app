class Asset < ApplicationRecord
  serialize :event_tags
  belongs_to :user
  has_many :ratings, dependent: :destroy
  belongs_to :location
  has_many :requests, dependent: :destroy
  has_many_attached :pictures, dependent: :destroy

  def avg_rating
    if self.ratings.any?
      rating_score_array = self.ratings.pluck(:score)
      rating_score_array.inject(0) { |sum, element| sum += element } / rating_score_array.length
    else
      "No reviews yet"
    end
  end
end
