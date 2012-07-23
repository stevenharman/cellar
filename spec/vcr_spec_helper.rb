require_relative '../config/initializers/brewery_db'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.stub_with :webmock
  c.ignore_localhost = true
  c.configure_rspec_metadata!
end

