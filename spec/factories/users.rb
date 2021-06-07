FactoryBot.define do
  factory :user do
    name { 'テスト' }
    sequence(:email) { |n| "email#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Time.zone.now }
    admin { false }
  end
end
