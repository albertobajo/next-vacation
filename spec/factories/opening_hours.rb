FactoryBot.define do
  factory :opening_hour do
    day_of_week { rand(0..6) }
    opens_at { rand(0...86_400) }
    closes_at { rand(1..86_400) }
    activity
  end
end
