FactoryBot.define do
  factory :beer do
    brew
    user
    vintage { (1970...2013).to_a.sample }
    best_by { (30..90).to_a.shuffle.first.days.from_now }

    trait(:cellared) { status 'cellared' }
    trait(:drunk) { status 'drunk' }
    trait(:skunked) { status 'skunked' }
    trait(:traded) { status 'traded' }
  end
end

