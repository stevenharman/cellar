FactoryGirl.define do
  factory :brewery do
    sequence(:name) { |n| "Thomas Creek - #{n}" }
    url "http://www.thomascreekbeer.com"
  end

  factory :brew do
    brewery
    sequence(:name) { |n| "Banana Split Chocolate Stout - #{n}"}
    abv { [5.2, 7.25, 8.5, 10.3, 11, 12.5].shuffle.first }
    description "ZOMG, it's Bananas! And chocolate!"
    ibu { [5, 30, 55, 99].shuffle.first }
  end

  factory :beer do
    brew
    user
    batch "2011B"
    bottled_on { rand(6).months.ago }
    best_by { (30..90).to_a.shuffle.first.days.from_now }
  end
end
