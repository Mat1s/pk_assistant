class OrganizationsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_organization,
    only: [:show, :edit, :update, :destroy, :change_state]
  skip_after_action :verify_authorized, only: :choosen_organizations
  skip_after_action :verify_policy_scoped, only: :choosen_organizations

  def index
    @organizations = policy_scope(Organization)
  end

  def show
    @organization_addresses = @organization.organization_addresses
    @service_for_organizations = @organization.service_for_organizations
    .eager_load(:service)
    @service_type = @organization.service_type["type_#{I18n.locale}"]
  end

  def new
    @organization = current_user.organizations.new
    authorize @organization
    @organization_addresses = @organization.organization_addresses.new
    @service_for_organizations = @organization.service_for_organizations.new
    @types = ServiceType.select("id, type_#{I18n.locale} as type")
  end

  def create
    clear_params = organization_params.to_h
    clear_params[:service_id] = params[:service_for_organizations][:service_id]
    clear_params[:organization_addresses] = params[:organization_addresses]
    result = CreateOrganizationAndServices.call(clear_params)
    @organization = result.organization
    authorize @organization
    binding.pry
    if result.success?
      @organizations = current_user.organizations
      .where(aasm_state: [:verified, :published])
      respond_to do |format|
        format.html { redirect_to @organization }
        format.js { @organizations }
      end
    else
      respond_to do |format|
        format.html { render :new, notice: "#{result.message}" }
        format.js { redirect_to root_url, notice: "#{result.message}" }
      end
    end
  end

  def edit
    @service_for_organizations = @organization.service_for_organizations

    @types = ServiceType
      .select("id, type_#{I18n.locale} as type")
      .where('id = ?', @organization.service_type_id)
    
    @services = Service
      .select("id, name_#{I18n.locale} as name")
      .where('service_type_id = ?', @organization.service_type_id).to_json

    @services_checked = ServiceForOrganization
      .select("id, service_id")
      .where('organization_id = ?', @organization.id).to_json

    respond_to do |format|
      format.js
    end
  end

  def update
    clear_params = organization_params.to_h
    clear_params[:id] = params[:id]
    if params[:service_for_organizations]
      clear_params[:service_id] = params[:service_for_organizations][:service_id]
    end
    result = ChangeOrganizationParams.call(clear_params)
    @organization = result.organization
    if result.success?
      redirect_back(fallback_location: root_path)
    else
      respond_to do |format|
        format.html { render :edit, notice: "#{result.message}" }
        format.js { redirect_to @organization, notice: "#{result.message}" }
      end
    end
  end

  def destroy
    @organization.destroy
    @organizations = current_user.organizations

    if @organizations
      respond_to do |format|
        format.html { render @organizations }
        format.js { @organizations }
      end
    else
      redirect_to root_url
    end
  end

  def change_state
    @organization.verified? ? @organization.publish! : @organization.unpublish!
    redirect_back(fallback_location: root_path)
  end

  def checkboxes
    authorize Organization
    if type = params[:type_of_service].to_i
      @services = Service
        .select("id, name_#{I18n.locale} as name")
        .where('service_type_id = ?', type)
    else
      @services = {}
    end
    respond_to do |format|
      format.json { render json: @services }
    end
  end

  def choosen_organizations
    service = Service.where("name_#{I18n.locale} = ?", params[:choosen_service]).first
    list_organization = ServiceForOrganization
      .where('service_id = ?', service.id)
      .pluck(:organization_id)
    @organizations_choosen = Organization.where(id: list_organization)
      .where(aasm_state: ['verified', 'published'])
      .pluck(:id, :name)
    respond_to do |format|
      format.json { render json: @organizations_choosen }
    end
  end

  private

  def set_organization
    @organization = Organization.find(params[:id])
    authorize @organization
  end

  def organization_params
    params.require(:organization).permit(:id, :user_id, :phone,
    :name, :email, :service_type_id, service_for_organizations_attributes:
    [:service_id], organization_addresses_attributes:
    [:city, :street, :house_number, :phone])
  end
end
Organization.where(id: 5).where(aasm_state: ['verified', 'published']).pluck(:id, :name)