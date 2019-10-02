class OperationMailerPreview < ActionMailer::Preview
  def estimate_time(operation)
    @operation = operation
    mail(
      to: @operation.email,
      subject: "Time or mileage expires for the next service!")
    p "haliova #{@operation.email}"
  end

  def notify_car_holder(email, make, operation)
  	@make = make
    @operation = operation
    @email = email
  	mail(
      to: @email,
      subject: "You passed service!")
  end
end
