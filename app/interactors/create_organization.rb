class CreateOrganization
  include Interactor
  # Create Organization not checked
  def call
    begin
      fail_organize = Organization.find_by(name: context.name)
      raise "This organization was created earlier" if fail_organize
      organization = Organization.new(user_id: context.user_id,
        phone: context.phone, name: context.name, email: context.email,
        service_type_id: context.service_type_id)
      organization.save
      context.organization = organization
    rescue => e
      context.fail!(message: e)
    end
  end
end
