class OrganizationAddressPolicy < ApplicationPolicy
   def new?
    user.present? && user.organization? 
  end

  def create?
    user.present? && user.organization? && (record.organization.user_id == user.id)
  end

  def edit?
    user.present? && user.organization? && (record.organization.user_id == user.id)
  end

  def update?
    user.present? && user.organization? && (record.organization.user_id == user.id)
  end

  def destroy?
  	user.present? && user.organization? && (record
  		.organization.user_id == user.id) || user.admin?
  end
end
