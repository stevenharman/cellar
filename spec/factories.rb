FactoryGirl.define do
  factory :brewery do
    sequence(:name) { |n| "Thomas Creek - #{n}" }
    url "http://www.thomascreekbeer.com"
  end

  factory :brew do
    brewery
    sequence(:name) { |n| "Banana Split Chocolate Stout - #{n}"}
    abv { [5.2, 7.25, 8.5, 10.3, 11, 12.5].shuffle.first }
  end
end
