class EventPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present? && (user.user? || user.admin?)
  end

  def update?
    user.present? && (user.admin? || record.user_id == user.id)
  end

  def destroy?
    user.present? && (user.admin? || record.user_id == user.id)
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.landlord?
        scope.where(user_id: user.id)
      else
        scope.where(public: true)
      end
    end
  end
end
