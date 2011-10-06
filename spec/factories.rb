FactoryGirl.define do
  factory :brewery do
    sequence(:name) { |n| "Thomas Creek - #{n}" }
  end
end
