class CreateOrganizationAndServices
  include Interactor::Organizer

  organize CreateOrganization, CreateServicesForOrganization,
  CreateAddressesForOrganization
end