class ChangeOrganizationParams
  include Interactor::Organizer

  organize ChangeOrganization, ChangeServicesForOrganization
end