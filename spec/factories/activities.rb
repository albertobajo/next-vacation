FactoryBot.define do
  factory :activity do
    sequence(:name) { |n| "Activity #{n}" }
    minutes_spent { rand(30..360) }
    lonlat { "POINT(#{Faker::Address.longitude} #{Faker::Address.latitude})" }
    category
    district
    location
  end
end
