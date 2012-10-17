require 'active_record'
require 'database_cleaner'

connection_info = YAML.load(ERB.new(File.read('config/database.yml')).result)['test']
ActiveRecord::Base.establish_connection(connection_info)

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

