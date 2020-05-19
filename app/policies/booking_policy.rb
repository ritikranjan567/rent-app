class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end

    def destroy?
      user.present? && ((booking.asset.user == user) || (booking.user == user))
    end

    private

    def booking
      record
    end
  end
end
