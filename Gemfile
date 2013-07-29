source 'https://rubygems.org'

ruby '1.9.3'
gem 'rails', '3.2.14'
gem 'jquery-rails'
gem 'unicorn'
gem 'brewery_db', '~> 0.2.0'
gem 'devise', '~> 3.0'
gem 'draper'
gem 'kaminari'
gem 'newrelic_rpm'
gem 'pg'
gem 'pg_search'
gem 'simple_form'
gem 'slim', '~> 2.0'
gem 'sinatra', require: false # for sidekiq monitoring
gem 'sidekiq'
gem 'virtus'

group :assets do
  gem 'sass-rails', '~> 3.1'
  gem 'bourbon', git: 'https://github.com/thoughtbot/bourbon.git'
  gem 'neat', '~> 1.3' # Grid framework built upon Bourbon.
  gem 'font-awesome-rails', '~> 3.2'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '>= 1.0.3'
end

gem 'rack-timeout', group: :production

group :development, :test do
  gem 'factory_girl_rails'
  gem 'foreman'
  gem 'forgery'
  gem 'heroku'
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'rspec-rails', '~> 2.14'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'mailcatcher'
end

group :test do
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'with_model'
  gem 'simplecov', require: false
  gem 'vcr'
  gem 'webmock'
end
