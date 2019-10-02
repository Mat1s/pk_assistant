class CreateProfile
  include Interactor
  # Create Profile after create User
  def call
    begin
      user = User.find_by(email: context[:email])
      c = context[:profile_attributes]
      profile = Profile.new(user_id: user.id,
        firstname: c[:firstname], surname: c[:surname],
        nickname: c[:nickname], address: c[:address],
        image: c[:image], birthday: c[:birthday])
    rescue => e
      context.fail!(message: e)
    end
  end
end
