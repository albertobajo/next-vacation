FactoryBot.define do
  factory :district do
    name { Faker::Address.community }
    city
  end
end
