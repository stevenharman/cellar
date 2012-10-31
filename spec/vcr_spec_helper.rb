require 'service_keys'
require 'vcr'

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock
  c.ignore_localhost = true
  c.configure_rspec_metadata!
  c.filter_sensitive_data('API_KEY') { ServiceKeys.brewery_db }
end

