ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start 'rails' if ENV['COVERAGE']

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'sidekiq/testing'
require_relative 'vcr_spec_helper'
require_relative 'active_record_spec_helper'

Dir[Rails.root.join('spec/support/**/*.rb')].each {|f| require f}

RSpec.configure do |config|

  # Let DatabaseCleaner handle this
  config.use_transactional_fixtures = false

  config.before(:each) do
    ActionMailer::Base.deliveries.clear
  end

  config.after(:suite) do
    if Rails.env.test?
      csv_uploader = CsvFileUploader.new
      FileUtils.rm_rf(Dir.glob("#{Rails.root}/public/#{csv_uploader.store_dir}"))
      FileUtils.rm_rf(Dir.glob("#{csv_uploader.cache_dir}"))
    end
  end

  config.include Devise::TestHelpers, type: :controller
  config.include ControllerTestHelpers, type: :controller
  config.include FeatureTestHelpers, type: :feature

  Capybara.javascript_driver = :webkit
end
