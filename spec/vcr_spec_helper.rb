ENV['RAILS_ENV'] ||= 'test'

(require 'dotenv'; Dotenv.load) unless defined?(Dotenv)
require 'service_keys'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock
  c.ignore_hosts 'codeclimate.com'
  c.ignore_localhost = true
  c.configure_rspec_metadata!
  c.filter_sensitive_data('API_KEY') { ServiceKeys.brewery_db }
end

