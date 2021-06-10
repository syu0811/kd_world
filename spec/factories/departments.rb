FactoryBot.define do
  factory :department do
    sequence(:name) { |n| "学科#{n}" }
    sequence(:alphabet, "A")
  end
end
