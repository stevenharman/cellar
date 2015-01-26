ENV['RAILS_ENV'] ||= 'test'

require 'active_record'
require 'database_cleaner'

connection_info = YAML.load(ERB.new(File.read('config/database.yml')).result)['test']
ActiveRecord::Base.establish_connection(connection_info)
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  # Because Capybara runs in a separate thread with a different database
  # connection, feature specs cannot use a transaction.
  config.before(type: :feature) do
    DatabaseCleaner.strategy = :truncation
  end

  # Reset so other non-feature specs don't have to deal with slow truncation.
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

