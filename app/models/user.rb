class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true, format: { with: Devise::email_regexp, message: "Invalid Email format" }
  validates :phone_number, uniqueness: true
  validates :first_name, :last_name, presence: true, length: {minimum:3, maximum: 30}
  has_many :assets, dependent: :destroy
  has_one :wishlist, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :requests, through: :assets, dependent: :destroy
  has_one_attached :profile_picture, dependent: :destroy
  #validates :profile_picture, content_type: ['image/png', 'image/jpg', 'image/jpeg']
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :validatable

  has_many :notifications, dependent: :destroy
  delegate :wished_assets, to: :wishlist

  def assets_booked_by_user
    Asset.joins(:bookings).distinct("assets.id").where("bookings.user_id = ?", self.id)
  end

  def booked_assets_of_user
    Asset.joins(:bookings).distinct("assets.user_id").where("assets.user_id = ?", self.id)
  end
end
