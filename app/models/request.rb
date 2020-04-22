class Request < ApplicationRecord
  belongs_to :asset
  has_many :notes, dependent: :destroy
end
