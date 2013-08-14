require 'active_record'
require 'database_cleaner'

connection_info = YAML.load(ERB.new(File.read('config/database.yml')).result)['test']
ActiveRecord::Base.establish_connection(connection_info)

RSpec.configure do |config|
  # Let DatabaseCleaner handle this
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  # Because Capybara runs in a separate thread with a different database
  # connection, feature specs cannot use a transaction.
  config.before(type: :feature) do
    DatabaseCleaner.strategy = :truncation
  end

  # Reset so other non-request specs don't have to deal with slow truncation.
  config.after(type: :feature) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

