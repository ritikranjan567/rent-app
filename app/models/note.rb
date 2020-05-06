class Note < ApplicationRecord
  belongs_to :request
  validates :content, presence: true
  belongs_to :user
end
