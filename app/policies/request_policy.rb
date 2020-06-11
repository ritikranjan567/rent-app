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
    user.present? && request.asset.user == user && request.request_status != 'accepted'
  end

  def destroy?
    user.present? && (request.requestor.eql?(user) || request.asset.user.eql?(user))
  end
  private

  def request
    record
  end
end
