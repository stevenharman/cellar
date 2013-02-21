FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "bob-#{n}" }
    email { |u| "#{u.username}@example.com" }
    password 'password123'
    confirmed_at  { Time.now.utc }

    factory(:bob) { username 'bob' }
    factory(:alice) { username 'alice' }

    trait :unconfirmed do
      confirmed_at nil
      confirmation_token { Devise.friendly_token }
    end
  end

end
