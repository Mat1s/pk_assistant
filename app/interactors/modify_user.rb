class ModifyUser
  include Interactor
  # ModifyUserRole to Organization
  def call
    begin
      user = User.find_by(id: context.user_id)
      unless  user.admin? && user.organization?
        user.organization!
      end
    rescue => e
      context.fail!(message: e)
    end
  end
end
