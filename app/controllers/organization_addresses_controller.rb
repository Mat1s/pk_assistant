class OrganizationAddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organization
  before_action :set_organization_address, only: [:edit, :update, :destroy]

  def new
    @organization_address = OrganizationAddress.new
    authorize @organization_address
  end

  def create
    @organization_address = @organization.organization_addresses
      .new(address_params)
    authorize @organization_address
    if @organization_address.save
      @organization_addresses = @organization.organization_addresses
      respond_to do |format|
          format.html { redirect_to @organization }
          format.js { @organization_addresses }
        end
    else
      redirect_to @organization
    end
  end

  def edit
  end

  def update
    if @organization_address.update(address_params)
      @organization_addresses = @organization.organization_addresses
        respond_to do |format|
          format.html { redirect_to @organization }
          format.js { @organization_addresses }
        end
    else
      redirect_to @organization
    end
  end

  def destroy
    @id_delete = @organization_address.id

    if @organization_address.destroy
      respond_to do |format|
        format.html { render @organization }
        format.js { @id_delete }
      end
    end
  end

  private

  def set_organization
    @organization = Organization.find_by(id: params[:organization_id])
  end

  def set_organization_address
    @organization_address = @organization.organization_addresses.find(params[:id])
    authorize @organization_address
  end

  def address_params
  params.require(:organization_address).permit(:city, :street, :house_number,
    :organization_id, :phone)
  end
end
