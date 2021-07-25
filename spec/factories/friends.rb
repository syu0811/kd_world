FactoryBot.define do
  factory :friend do
    association :user, factory: :user
    association :friend, factory: :user
  end
end
