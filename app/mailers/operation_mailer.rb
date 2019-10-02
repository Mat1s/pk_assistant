class OperationMailer < ApplicationMailer

  def estimate_time(operation)
    @operation = operation
    I18n.with_locale(operation.locale) do
      mail( to: @operation.email,
        subject: I18n.t('operation_mailer.estimate_time.subject')) do |format|
        format.text
        format.html
      end
    end
    p "called estimate_time. Operation - #{@operation.id}"
  end

  def notify_car_holder(email, make, operation)
    @make = make
    @operation = operation
    @email = email
    user = User.find_by(email: email)
    I18n.with_locale(user.locale) do
      mail( to: @email,
        subject: I18n.t('operation_mailer.notify_car_holder.subject')) do |format|
        format.text
        format.html
      end
    end
    p "called notify_car_holder. Operation #{@operation.id}"
  end
end
