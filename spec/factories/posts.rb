FactoryBot.define do
  factory :post do
    association :user
    body { 'テスト' }
    association :topic
  end
end
