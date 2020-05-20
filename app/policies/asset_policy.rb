class AssetPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end

    def destroy?
      record.user_id.eql? user.id
    end
  end
end
