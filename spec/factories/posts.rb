FactoryBot.define do
  factory :post do
    association :user
    body { 'ใในใ' }
    association :topic
  end
end
