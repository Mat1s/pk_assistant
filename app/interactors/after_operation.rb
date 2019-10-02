class AfterOperation
  include Interactor
  # After Operation
  def call
    begin
      if context.operations_last
        operations = Operation.where( id: context.operations_last )
        operations.each do |operation|
            operation.state = false 
            operation.save
        end
      end
    rescue => e
      context.fail!(message: e)
    end
  end
end
