class CreateServicesForOrganization
  include Interactor
  # Create Services which Organization will do
  def call
    begin
      binding.pry
      context[:service_id].each do |s8d|
        context.organization.service_for_organizations.create(service_id: s8d)
      end
    rescue => e
      context.fail!(message: e)
    end
  end
end
