source 'https://rubygems.org'

ruby '1.9.3'
gem 'rails', '3.2.13'
gem 'jquery-rails'
gem 'unicorn'
gem 'brewery_db', github: 'tylerhunt/brewery_db'
gem 'devise', '~> 2.1'
gem 'draper'
gem 'kaminari'
gem 'newrelic_rpm'
gem 'pg'
gem 'pg_search'
gem 'simple_form'
gem 'slim', '~> 1.3'
gem 'sinatra', require: false # for sidekiq monitoring
gem 'sidekiq'
gem 'virtus'

group :assets do
  gem 'sass-rails', '~> 3.1'
  gem 'bootstrap-sass', '~> 2.3.0'
  gem 'font-awesome-sass-rails'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '>= 1.0.3'
end

gem 'rack-timeout', group: :production

group :test do
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'with_model'
  gem 'simplecov', require: false
  gem 'vcr'
  gem 'webmock'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'foreman'
  gem 'forgery'
  gem 'heroku'
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'rspec-rails', '~> 2.12'
end

gem 'mailcatcher', group: :development
