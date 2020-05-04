class Note < ApplicationRecord
  belongs_to :request
  validates :content, presence: true
  validates :userid, presence: true, uniqueness: true
end
