require 'faker'
FactoryBot.define do
  factory :profile do
    nickname  { Faker::Name.name }
    firstname { Faker::Name.name }
    surname   { Faker::FunnyName.name }
    address   { 'Tolstogo str. 10' }
    birthday  { (Time.now - 18.years).strftime("%F") }
    image     { File.open("#{Rails.root}/spec/fixtures/download.jpeg") }
    user
  end
end