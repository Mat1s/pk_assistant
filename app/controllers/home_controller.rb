class HomeController < ApplicationController
  skip_after_action :verify_authorized, only: [:change_locale, :search]
  skip_after_action :verify_policy_scoped, only: [:change_locale, :search]
  def index
    @organization_count = Organization.count
    @organizations = policy_scope(Organization).page params[:page]
  end

  def change_locale
    locale = params[:locale].to_s
    cookies.permanent.encrypted[:locale] = locale
    if current_user 
      current_user.locale = locale
      current_user.save
    end
    redirect_back(fallback_location: root_path)
  end

  def search
    @service_types = ServiceType.select("id, type_#{I18n.locale} as type")
    if params[:search].presence
      query = params[:search][:query]
      if params[:search][:service_type] != ''
        service_type = [params[:search][:service_type].to_i]
      else
        service_type = (1..7).to_a
      end
    end

    if query
      @results = ServiceForOrganization.search_published(query, service_type)
    end
  end
end
