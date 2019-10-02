class CarsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  def show
    @operations = @car.operations
    @operations_need_processed = Operation.
      find_by_sql [" select * from operations
      where car_id = ?
      and state is true
      and (next_mileage - current_mileage < 1000
      or next_time - NOW() < interval '3 month')", @car.id]
  end

  def new
    @car = current_user.cars.new
    authorize @car
    @make = TypeCar.distinct.pluck(:make).sort!
    @model = TypeCar.distinct.pluck(:model).sort!
    @year = TypeCar.distinct.pluck(:year).sort!
    @fuel_type = I18n.t('car.array.fuel_type').split
    @vehicle_type = I18n.t('car.array.vehicle_type').split
    @transmission = I18n.t('car.array.transmission').split
  end

  def create
    @car = Car.new(car_params)
    authorize @car
    if @car.save
      @cars = current_user.cars
      respond_to do |format|
        format.html { redirect_to @car }
        format.js { @cars }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.js { @car }
      end
    end
  end

  def edit
  end

  def update
    if @car.update(car_params)
      @car.operations.each  do |operation|
        operation.current_mileage = @car.mileage
        operation.save!
      end
      @cars = current_user.cars
      respond_to do |format|
        format.html { redirect_to @profile }
        format.js { @cars }
      end
    else
      redirect_to root_url
    end
  end

  def destroy
    @id_delete = @car.id
    @profile = current_user.profile

    if @car.destroy
      respond_to do |format|
        format.html { redirect_to @profile }
        format.js { @id_delete }
      end
    end
  end

  def models
    authorize Car
    if make = params[:make]
      @model = TypeCar.where('make = ?', make).distinct.pluck(:model).sort!
    else
      @model = {}
    end
    respond_to do |format|
      format.json { render json: @model }
    end
  end

  def years
    authorize Car
    model = params[:model]
    make = params[:make]
    if model && make
      @year = TypeCar.where('make = ? and model = ?', make, model)
        .distinct.pluck(:year).sort!
    else
      @year = {}
    end
    respond_to do |format|
      format.json { render json: @year }
    end
  end

  private

  def set_car
    @car = current_user.cars.find_by(id: params[:id])
    authorize @car
  end

  def car_params
    params.require(:car).permit(:user_id, :make, :model, :year, :vehicle_type,
    :fuel_type, :cubic_capacity, :transmission, :purchase_date, :mileage,
    :description)
  end
end
