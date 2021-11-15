FactoryBot.define do
  factory :friend_request do
    association :user, factory: :user
    association :applicant, factory: :user
  end
end
