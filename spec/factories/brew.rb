require 'securerandom'

FactoryBot.define do
  factory :brew do
    style
    brewery_db_id { SecureRandom.hex(3) }
    name { Forgery::Name.industry }
    description { Forgery::LoremIpsum.paragraphs(rand 2...4)}
    abv { rand(200..2000)/100.0 }
    ibu { rand(5..110) }
    original_gravity { rand(1030..1060)/1000.0 }
    year { Date.new(rand(2000..2012)) }
    organic { Forgery::Basic.boolean }

    after(:build) { |brew| brew.breweries << FactoryBot.create(:brewery) }
  end
end
