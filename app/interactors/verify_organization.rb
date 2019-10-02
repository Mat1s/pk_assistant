class VerifyOrganization
  include Interactor
  # Verify Organization 
  def call
    begin
      if context[:commit] == 'Approve'
        organization = Organization.find_by(id: context[:id])
        organization.verify if organization.unverified?
        organization.publish if organization.verified?
        organization.save
      elsif context[:commit] = 'Reject'
        organization = Organization.find_by(id: context[:id])
        organization.reject
        organization.save
        raise context[:description]
      end
    rescue => e
      context.fail!(message: e)
    end
  end
end
