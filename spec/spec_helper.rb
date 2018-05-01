ENV['RAILS_ENV'] ||= 'test'

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start if ENV['COVERAGE']

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

  config.fixture_path = "#{Rails.root}/spec/support/fixtures"

  config.before(:suite) do
    Sidekiq::Testing.fake!
  end

  config.before(:each) do
    ActionMailer::Base.deliveries.clear
    Sidekiq::Worker.clear_all
  end

  config.before(type: :feature, js: true) do
    capy_server = Capybara.current_session.server
    Rails.application.config.action_mailer.default_url_options[:host] = "#{capy_server.host}:#{capy_server.port}"
  end

  config.after(:suite) do
    if Rails.env.test?
      csv_uploader = CsvFileUploader.new
      FileUtils.rm_rf(Dir.glob("#{Rails.root}/public/#{csv_uploader.store_dir}"))
      FileUtils.rm_rf(Dir.glob("#{csv_uploader.cache_dir}"))
    end
  end

  config.infer_spec_type_from_file_location!
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include ControllerTestHelpers, type: :controller
  config.include FeatureTestHelpers, type: :feature
  config.include RequestTestHelpers, type: :request

  WebMock.disable_net_connect!(allow: 'codeclimate.com')
end
