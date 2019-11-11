FactoryBot.define do
  factory :location do
    name { %w[outdoors indoors].sample }
  end
end
