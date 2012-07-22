require 'securerandom'

FactoryGirl.define do
  factory :brewery do
    brewery_db_id { SecureRandom.hex(3) }
    name { Forgery::Name.company_name }
    description { Forgery::LoremIpsum.paragraphs(2) }
    established { Forgery::Date.date }
    organic { Forgery::Basic.boolean }
    website { "http://www.#{name.downcase}.com" }
  end
end
