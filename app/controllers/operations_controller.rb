class OperationsController < ApplicationController
  before_action :authenticate_user!
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def show
    @operation = Operation.find_by(id: params[:id])
  end

  def new
    all_id_permit_organizations = Organization
      .where(aasm_state: ['published', 'verified']).ids
    all_id_services = ServiceForOrganization
      .where(organization_id: all_id_permit_organizations)
      .distinct.pluck(:service_id)
    @services = Service.select("name_#{I18n.locale} as name")
      .where(id: all_id_services)
    @car = Car.find_by(id: params[:car_id])
    @operation = @car.operations.new
    respond_to do |format|
      format.js
    end
  end

  def create
    result = CreateOperation.call(operation_params)
    @oeration = result.operation
    if result.success?
      respond_to do |format|
        format.html { redirect_to @car }
        format.js { @operation }
      end
    else
      respond_to do |format|
        format.html { render :new, notice: "#{result.message}" }
        format.js { redirect_to root_url, notice: "#{result.message}" }
      end
    end
  end

  def edit
    @car = Car.find_by(id: params[:car_id])
    @operation = @car.operations.new
    operation_id = Operation.find(params[:id]).service_id
    @services = Service.select("name_#{I18n.locale} as name")
    .where('id = ?', operation_id)
  end

  private

  def operation_params
    params.require(:operation).permit(:car_id, :organization_id, :service_id,
      :next_mileage, :next_time, :price)
  end
end
