class Asset < ApplicationRecord
  serialize :event_tags
  belongs_to :user
  has_one :rating, dependent: :destroy
  has_one :location, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many_attached :pictures
end
