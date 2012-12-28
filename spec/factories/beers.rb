FactoryGirl.define do
  factory :beer do
    brew
    user
    batch '2011B'
    bottled_on { rand(6).months.ago }
    best_by { (30..90).to_a.shuffle.first.days.from_now }

    trait(:cellared) { status :cellared }
    trait(:drunk) { status :drunk }
    trait(:skunked) { status :skunked }
    trait(:traded) { status :traded }
  end
end

