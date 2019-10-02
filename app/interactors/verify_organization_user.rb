class VerifyOrganizationUser
  include Interactor::Organizer

  organize VerifyOrganization, ModifyUser
end