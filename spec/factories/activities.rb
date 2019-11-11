FactoryBot.define do
  factory :activity do
    name { Faker::Company.name }
    minutes_spent { rand(30..360) }
    lonlat { "POINT(#{Faker::Address.longitude} #{Faker::Address.latitude})" }
    category
    district
    location
  end
end
