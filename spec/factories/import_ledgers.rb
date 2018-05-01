include ActionDispatch::TestProcess

FactoryBot.define do
  factory :import_ledger, class: 'Import::Ledger' do
    user
    csv_file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'fixtures', 'founders-breakfast-stout.csv')) }

    factory :import_ledger_with_candidate_beers do
      after(:create) do |ledger, evaluator|
        create_list(:import_candidate_beer, 1, :medium_confidence, ledger: ledger)
      end
    end
  end

  factory :import_candidate_beer, class: 'Import::CandidateBeer' do
    association :ledger, factory: :import_ledger

    trait :no_confidence do
      confidence :none
    end

    trait :medium_confidence do
      confidence :medium
      brew
    end

    trait :high_confidence do
      confidence :high
      brew
    end

    trait :confirmed do
      confidence :confirmed
      brew
    end
  end
end
