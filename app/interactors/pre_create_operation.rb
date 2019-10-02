class PreCreateOperation
  include Interactor
  # PreCreate Operaton
  def call
    begin
      car = Car.find_by(id: context.car_id)
      context.car = car
      service_id = Service.where( "name_#{I18n.locale} = ?",
        context.service_id ).first.id
      context.service_id = service_id
      operations_last = Operation.where(car_id: context.car_id,
        service_id: service_id, state: true).ids
      context.operations_last = operations_last
    rescue => e
      context.fail!(message: e)
    end
  end
end
