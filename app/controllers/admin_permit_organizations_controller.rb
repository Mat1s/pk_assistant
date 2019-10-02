class AdminPermitOrganizationsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_for_admin
  before_action :set_organization, only: [:show, :edit, :update, :destroy]

  def index
    @organizations = policy_scope(Organization).unverified.eager_load(:service_type)
  end

  def show
    @organization_addresses = @organization.organization_addresses
    @service_for_organizations = @organization.service_for_organizations
    .eager_load(:service)
  end

  def edit
  end

  def update
    clear_params = organization_params
    clear_params[:id] = params[:id]
    clear_params[:description] = params[:description]
    clear_params[:commit] = params[:commit]
    result = VerifyOrganizationUser.call(clear_params)
    if result.success?
      @organizations = Organization.unverified.eager_load(:service_type)
      respond_to do |format|
        flash[:success] = I18n.t('admin.update.success')
        format.html { redirect_to admin_permit_organizations_path }
        format.js { @organizations }
      end
    else
      redirect_to admin_permit_organizations_path, danger: "#{result.message}"
    end
  end

  private
  def set_organization
    @organization = Organization.find_by(id: params[:id])
    authorize @organization
  end

  def check_for_admin
    redirect_to root_url, notice: I18n.t('pundit.admin') unless current_user.admin?
  end

  def organization_params
    params.require(:organization).permit(:id, :description, :commit, :user_id)
  end
end
