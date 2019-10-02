class CreateOperation
  include Interactor::Organizer

  organize PreCreateOperation, SaveOperation,
  AfterOperation, NotifyCarHolder
end