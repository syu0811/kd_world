FactoryBot.define do
  factory :topic do
    title { 'ใในใ' }
    association :user
  end
end
