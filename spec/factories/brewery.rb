require 'securerandom'

FactoryGirl.define do
  factory :brewery do
    sequence(:name) { |n| "Thomas Creek - #{n}" }
    website "http://www.thomascreekbeer.com"
    brewery_db_id { SecureRandom.hex(3) }
  end
end
