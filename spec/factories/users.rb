FactoryBot.define do
  factory :user do
    name { 'ใในใ' }
    sequence(:email) { |n| "kd#{1_000_000 + n}@st.kobedenshi.ac.jp" }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Time.zone.now }
    admin { false }
    association :department
  end
end
