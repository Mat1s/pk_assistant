class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  type_of_callbacks = [:facebook, :twitter, :linkedin]

  type_of_callbacks.each do |elem|
    define_method(elem) do
      result = CreateUserAndProfileFromOmniauth
      .call(request.env['omniauth.auth'])
      @user = result.user
      if result.success? && @user && @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        flash[:notice] = I18n.t 'devise.omniauth_callbacks.success',
        kind: elem.to_s.capitalize
      else
        session["devise.#{elem}_data"] = request.env['omniauth.auth']
        .except('extra')
        redirect_to new_user_registration_url
      end
    end
  end

  def failure
    redirect_to root_path
  end
end
