class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates :phone_number, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true
  has_many :assets, dependent: :destroy
  has_one :wishlist, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_one_attached :profile_picture, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :validatable
end
