class CreateProfileFromOmniauth
  include Interactor
  # Create Profile from Auth if create User
  def call
    begin
      user = User.find_by(id: context.user_id)
      Profile.where('user_id = ?', context.user_id).first_or_initialize do |profile|
        if context.provider.match(/twitter|facebook/i)
          str = context.info.name
          context.info.first_name = str.partition(' ').first
          context.info.last_name = str.partition(' ').last
        end
        context.info.nickname = context.info.name unless context.info.nickname
        profile.user_id = context.user_id
        profile.firstname = context.info.first_name
        profile.surname = context.info.last_name
        profile.nickname = context.info.nickname
        profile.address = context.provider
        profile.birthday = Time.now - 16.years
        profile.remote_image_url = context.info.image.gsub!('http://','https://')
        profile.save
      end
      context.user = user
    rescue => e
      context.fail!(message: e)
    end
  end
end
