class Request < ApplicationRecord
  belongs_to :asset
  has_one :event, dependent: :destroy
  has_many :notes, dependent: :destroy
end
