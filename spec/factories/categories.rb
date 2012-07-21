FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Category ##{n}" }
    sequence(:brewery_db_id)
  end
end
