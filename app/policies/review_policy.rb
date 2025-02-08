class ReviewPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def destroy?
    user.present? && (user.admin? || record.user_id == user.id)
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
