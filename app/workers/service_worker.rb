class ServiceWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'low'

  def perform
    operations = Operation.find_by_sql("
    select op.id, c.make as make, u.email as email, u.locale as locale, c.id as car_id,
     (op.next_mileage - op.current_mileage) as mileage    
    from operations op
    inner join cars c on c.id = op.car_id
    inner join users u on u.id = c.user_id
    where op.next_mileage - op.current_mileage < 1000 
    or op.next_time - NOW() < interval '3 month'
    and op.state is true")
    operations.each { |operation| OperationMailer.estimate_time(operation).deliver_now }
  end
end
