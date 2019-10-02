class ChangeOrganization
  include Interactor
  # Change Organization params
  def call
    begin
      organization = Organization.find_by(id: context.id)
      organization.email = context.email
      organization.phone = context.phone
      organization.name = context.name
      organization.save
      context.organization = organization
    rescue => e
      context.fail!(message: e)
    end
  end
end
