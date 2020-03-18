class Wishlist < ApplicationRecord
  belongs_to :user
  has_many :wished_assets, dependent: :destroy
end
