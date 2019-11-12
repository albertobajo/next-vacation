FactoryBot.define do
  factory :district do
    sequence(:name) { |n| "District #{n}" }
    city
  end
end
