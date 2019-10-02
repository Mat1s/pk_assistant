FactoryBot.define do
  factory :organization do
    type_of_service { "MyString" }
    name { "MyString" }
    email { "MyString" }
    phone { 1 }
  end
end
