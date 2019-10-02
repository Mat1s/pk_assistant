class CreateUserFromOmniauth
  include Interactor
  # Create User from Auth
  def call
    begin
      user = User.where('provider = ? and uid = ?', context.provider, context.uid)
          .first_or_initialize do |user|
        if context.info.email
          user.email = context.info.email
        else
          user.email = context.uid + '@' + context.provider + '.com'
        end
        user.password = Devise.friendly_token[0,20]
        user.uid = context.uid
        user.provider = context.provider
        user.role = :user
        user.skip_confirmation!
        user.save
      end
      context.user_id = user.id
    rescue => e
      context.fail!(message: e)
    end
  end 
end
