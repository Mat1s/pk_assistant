class ServiceTypeImport
  def self.import
    ServiceType.create!(type_en: 'MOT', type_ru: 'ГТО', type_es: 'ITE')
    ServiceType.create!(type_en: 'Tyre service', type_ru: 'Шиномонтаж', type_es: 'Servicio de neumáticos')
    ServiceType.create!(type_en: 'Service station', type_ru: 'СТО', type_es: 'Estación de servicio')
    ServiceType.create!(type_en: 'Auto parts store', type_ru: 'Магазин автозапчастей', type_es: 'Tienda de auto partes')
    ServiceType.create!(type_en: 'Car wash', type_ru: 'Автомойка', type_es: 'Lavado de autos')
    ServiceType.create!(type_en: 'Insurance', type_ru: 'Страховая компания', type_es: 'Seguro')
    ServiceType.create!(type_en: 'Department of motor vehicles', type_ru: 'Государственная автомобильная инспекция', type_es: 'Cuerpo Nacional de Policía')
    puts "ServiceTypes imported"
  end
end