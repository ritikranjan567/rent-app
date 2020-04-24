class Asset < ApplicationRecord
  serialize :event_tags
  belongs_to :user
  has_one :rating, dependent: :destroy
  belongs_to :location
  has_many :requests, dependent: :destroy
  has_many_attached :pictures, dependent: :destroy

  scope :name_like, ->(name) { where('name like ?', "%#{name}%") }
  scope :event_tag_like, ->(event_tag) { where('event_tags like ?', "%#{event_tag}%") }
end
