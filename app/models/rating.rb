class Rating < ApplicationRecord
  belongs_to :asset
  validates :user_id, presence: true, uniqueness: true  
end
