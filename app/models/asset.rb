class Asset < ApplicationRecord
  serialize :event_tags
  belongs_to :user
  has_one :rating, dependent: :destroy
  belongs_to :location
  has_many :requests, dependent: :destroy
  has_many_attached :pictures, dependent: :destroy
end
