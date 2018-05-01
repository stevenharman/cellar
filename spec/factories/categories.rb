FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "Category ##{n}" }
    brewery_db_id { SecureRandom.random_number(999_999_999) }
  end
end
