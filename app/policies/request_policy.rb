class RequestPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    user.present? && (user == request.requestor || user == request.asset.user)
  end

  def update?
    user.present? && request.asset.user == user && request.request_status != 'accepted' && request.asset.available
  end

  private

  def request
    record
  end
end