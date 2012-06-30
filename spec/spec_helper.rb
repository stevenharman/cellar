ENV["RAILS_ENV"] ||= 'test'

require 'simplecov'
SimpleCov.start 'rails' do
  add_filter 'spec_no_rails'
end if ENV["COVERAGE"]

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true
  config.include Devise::TestHelpers, type: :controller
  config.extend ControllerHelpers, type: :controller
end
