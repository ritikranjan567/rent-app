class Request < ApplicationRecord
  belongs_to :asset
  has_many :notes, dependent: :destroy
  validates :event_name, presence: true, length: {minimum: 3, maximum: 50}, format: { with: /\A[^0-9`!@#\$%\^&*+_=]+\z/, message: "is Invalid" } 
  validates :event_description, presence: true, length: {minimum: 10, maximum: 300}
  validates :user_id, uniqueness: { message: "You have already reuqested this one" }

end
