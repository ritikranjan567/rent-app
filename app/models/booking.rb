class Booking < ApplicationRecord
  #include Notificable
  belongs_to :asset
  belongs_to :request
  belongs_to :user
  def to_requestor_id
    self.request.requestor_id
  end
  def to_owner_id
    self.asset.user_id
  end

end
