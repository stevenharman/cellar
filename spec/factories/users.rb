FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "bob-#{n}" }
    email { |u| "#{u.username}@example.com" }
    password 'password123'

    factory(:bob) { username 'bob' }
    factory(:alice) { username 'alice' }
  end
end
