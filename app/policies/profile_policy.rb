class ProfilePolicy < ApplicationPolicy
  def show?
   true
  end

  def edit?
    user.present? && record.user_id == user.id
  end

  def update?
    user.present? && record.user_id == user.id
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
