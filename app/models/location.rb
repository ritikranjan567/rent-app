class Location < ApplicationRecord
  has_many :assets, dependent: :destroy
end
