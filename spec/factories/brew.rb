FactoryGirl.define do
  factory :brew do
    brewery
    sequence(:name) { |n| "Banana Split Chocolate Stout - #{n}"}
    abv { [5.2, 7.25, 8.5, 10.3, 11, 12.5].shuffle.first }
    description "ZOMG, it's Bananas! And chocolate!"
    ibu { [5, 30, 55, 99].shuffle.first }
  end
end