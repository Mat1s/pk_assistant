class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery

  add_flash_types :error, :danger, :warning, :info

  after_action :verify_authorized, except: :index, unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index, unless: :devise_controller?
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from Pundit::NotDefinedError, with: :object_not_found
  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:error] = t "#{policy_name}.#{exception.query}", scope: "pundit",
    default: :default
    redirect_to(request.referrer || root_path)
  end

  def object_not_found
    flash[:error] = 'This path not found'
    redirect_to root_url
  end

  def set_locale
    I18n.locale = cookies.encrypted[:locale] || current_user
      .try(:locale) || I18n.default_locale
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email,
      :password, :password_confirmation, profile_attributes: [:image, :firstname,
      :surname, :nickname, :address, :birthday, :user_id]])
  end
end
