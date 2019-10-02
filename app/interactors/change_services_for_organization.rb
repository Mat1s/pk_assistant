class ChangeServicesForOrganization
  include Interactor
  # Change Services for Organization
  def call
    begin
      if context.service_id
        old_sfo = ServiceForOrganization.where(organization_id: context.id)
        .pluck(:service_id).map {|a| a.to_s}
        current_sfo = context.service_id
        service_for_delete = old_sfo - current_sfo
        service_for_add = current_sfo - old_sfo
        service_for_delete.each do |s|
          ServiceForOrganization.find_by(service_id: s).delete
        end
        service_for_add.each do |s|
          ServiceForOrganization.create(service_id: s, organization_id: context.id)
        end
      end
    rescue => e
      context.fail!(message: e)
    end
  end
end
