class NotifyCarHolder
  include Interactor
  # Notify carholder about passed operation
  def call
    begin
    	user = User.find_by(id: context.car.user_id)
      OperationMailer
      .notify_car_holder(user.email, context.car.make, context.operation)
      .deliver_later
    rescue => e
      context.fail!(message: e)
    end
  end
end
