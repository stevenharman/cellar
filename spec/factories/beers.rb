FactoryGirl.define do
  factory :beer do
    brew
    user
    status :stocked
    batch "2011B"
    bottled_on { rand(6).months.ago }
    best_by { (30..90).to_a.shuffle.first.days.from_now }

    trait(:drunk) { status :drunk }
    trait(:traded) { status :traded }
    trait(:skunked) { status :skunked }
  end
end

