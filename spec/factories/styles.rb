FactoryGirl.define do
  factory :style do
    name  { |n| "Style ##{n}" }
    brewery_db_id { SecureRandom.random_number(999_999_999) }
    category
  end
end
