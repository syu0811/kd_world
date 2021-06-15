FactoryBot.define do
  factory :topic do
    title { 'テスト' }
    association :user
  end
end
