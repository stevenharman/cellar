include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :import_ledger, class: 'Import::Ledger' do
    user
    csv_file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'fixtures', 'founders-breakfast-stout.csv')) }
  end
end
