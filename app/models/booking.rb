class Booking < ApplicationRecord
  #include Notificable
  belongs_to :asset
  belongs_to :request
  belongs_to :user

end
