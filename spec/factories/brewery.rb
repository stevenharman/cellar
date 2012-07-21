require 'securerandom'

FactoryGirl.define do
  factory :brewery do
    name { Forgery::Name.company_name }
    brewery_db_id { SecureRandom.hex(3) }
    description { Forgery::LoremIpsum.paragraphs(2) }
    established { Forgery::Date.date }
    organic { Forgery::Basic.boolean }
    website { "http://www.#{name.downcase}.com" }
  end
end
