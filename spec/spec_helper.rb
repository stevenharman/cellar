ENV["RAILS_ENV"] ||= 'test'

require 'simplecov'
SimpleCov.start 'rails' if ENV["COVERAGE"]

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require_relative 'vcr_spec_helper'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.use_transactional_fixtures = false # database_cleaner handles this

  config.before :suite do
    DatabaseCleaner.strategy = :transaction
  end

  # Request specs cannot use a transaction because Capybara runs in a
  # separate thread with a different database connection.
  config.before type: :request do
    DatabaseCleaner.strategy = :truncation
  end

  # Reset so other non-request specs don't have to deal with slow truncation.
  config.after type: :request do
    DatabaseCleaner.strategy = :transaction
  end

  config.before do
    DatabaseCleaner.start
    ActionMailer::Base.deliveries.clear
  end

  config.after do
    DatabaseCleaner.clean
  end

  config.include Devise::TestHelpers, type: :controller
  config.extend ControllerHelpers, type: :controller
  config.include AcceptanceTestHelpers, type: :request

  Capybara.javascript_driver = :webkit
end
