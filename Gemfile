source 'https://rubygems.org'

ruby '2.0.0'
gem 'rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'unicorn'
gem 'brewery_db', '~> 0.2.0'
gem 'devise', '~> 3.0'
gem 'draper'
gem 'kaminari'
gem 'newrelic_rpm'
gem 'pg'
gem 'pg_search'
gem 'simple_form', '~> 3.0.0.rc'
gem 'slim', '~> 2.0'
gem 'sinatra', require: false # for sidekiq monitoring
gem 'sidekiq'
gem 'virtus'

gem 'sass-rails', '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'bourbon', git: 'https://github.com/thoughtbot/bourbon.git'
gem 'neat', '~> 1.3' # Grid framework built upon Bourbon.
gem 'font-awesome-rails', '~> 3.2'

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
  gem 'mailcatcher', git: 'https://github.com/sj26/mailcatcher.git'
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

gem 'protected_attributes', '~> 1.0.1'
