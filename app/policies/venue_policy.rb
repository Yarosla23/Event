class VenuePolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    user.present? && (user.landlord? || user.admin?)
  end

  def update?
    user.present? && (user.admin? || record.user_id == user.id)
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
