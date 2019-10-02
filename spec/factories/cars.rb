FactoryBot.define do
  factory :car do
    make { "MyString" }
    model { "MyString" }
    year { 1 }
    fuel_type { "MyString" }
    vehicle_type { "MyString" }
    cubic_capacity { 1.5 }
    transmission { "MyString" }
  end
end
