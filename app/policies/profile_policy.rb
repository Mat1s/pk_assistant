class ProfilePolicy < ApplicationPolicy

  def show?
    user.present? && record.user_id == user.id
  end

  def edit?
    user.present? && record.user_id == user.id
  end

  def update?
    user.present? && record.user_id == user.id
  end
end
