class CreateAddressesForOrganization
  include Interactor
  # Create Addresses for Organization
  def call
    begin
      context[:organization_addresses].each do |address|
        address = context.organization.organization_addresses.new(
        city: address[:city],
        street: address[:street],
        house_number: address[:house_number],
        phone: address[:phone])
        address.save
      end
    rescue => e
      context.fail!(message: e)
    end
  end
end
