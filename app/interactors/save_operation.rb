class SaveOperation
  include Interactor
  # Save Operaton
  def call
    begin
      operation = Operation.new(
        car_id: context.car_id,
        service_id: context.service_id,
        organization_id: context.organization_id,
        next_mileage: (context.car.mileage + context.next_mileage.to_i),
        next_time: (Time.now + context.next_time.to_i.month),
        price: BigDecimal.new(context.price),
        current_mileage: context.car.mileage
      )
      operation.save
      context.operation = operation
    rescue => e
      context.fail!(message: e)
    end
  end
end
