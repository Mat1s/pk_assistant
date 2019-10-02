require_relative('../storage/list_of_services')
require_relative('../storage/list_of_service_types')
require_relative('../storage/list_of_cars')

ServiceType.delete_all
Service.delete_all
TypeCar.delete_all
ServiceTypeImport.import
ServiceImport.import
CarsImport.import
CarsImport.import_from_json
