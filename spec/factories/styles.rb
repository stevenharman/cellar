FactoryGirl.define do
  factory :style do
    name  { |n| "Style ##{n}" }
    sequence(:brewery_db_id)
    category
  end
end
