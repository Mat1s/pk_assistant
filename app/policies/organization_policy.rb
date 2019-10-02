class OrganizationPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.present? && user.admin? && scope.present? && scope.unverified
        scope.all
      elsif user.present?
        scope.where(aasm_state: [:verified, :published])
      else
        scope.published
      end
    end
  end

  def show?
    true
  end

  def new?
    user.present?
  end

  def create?
    user.present? && ( record.user_id == user.id )
  end

  def edit?
    user.present? && user.admin? || (( record.user_id == user.id ) &&  user
      .organization?)
  end

  def update?
    user.present? && user.admin? || (( record.user_id == user.id ) &&  user
      .organization?)
  end

  def destroy?
    user.present? && user.admin? || (( record.user_id == user.id ) &&  user
      .organization?)
  end

  def checkboxes?
    user.present?
  end

  def change_state?
    user.present? && user.admin? || (( record.user_id == user.id ) &&  user
      .organization?)
  end

  def choosen_organizations?
    true
  end
end
