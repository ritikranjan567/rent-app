class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def destroy?
    user.present? && (record.user_id.eql?(user.id) || record.asset.user_id.eql?(user.id))
  end
end
