FactoryGirl.define do
  factory :brewery do
    sequence(:name) { |n| "Thomas Creek - #{n}" }
    url "http://www.thomascreekbeer.com"
  end
end