class CarPolicy < ApplicationPolicy

  def show?
    user.present? && ( user.admin? || user.id == record.user_id)
  end

  def new?
    user.present?
  end

  def create?
    user.present?
  end

  def edit?
    user.present? && user.id == record.user_id
  end

  def update?
    user.present? && user.id == record.user_id
  end

  def destroy?
    user.present? && ( user.admin? || user.id == record.user_id )
  end

  def models?
    user.present?
  end

  def years?
    user.present?
  end
end
