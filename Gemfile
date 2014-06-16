source 'https://rubygems.org'

ruby '2.1.2'
gem 'rails', '~> 4.1.1'

# Must be early in Gemfile so it's loaded before libs that depend on ENV Vars
gem 'dotenv-rails', '~> 0.11', groups: [:development, :test]

gem 'puma'

gem 'active_model_serializers', github: 'stevenharman/active_model_serializers', branch: 'make_url_generator_available'
gem 'brewery_db', '~> 0.2.0'
gem 'carrierwave', '~> 0.10.0'
gem 'devise', '~> 3.1'
gem 'draper', github: 'stevenharman/draper', branch: 'compatibility_with_active_model_serializers_next'
gem 'fog', '~> 1.15'
gem 'kaminari'
gem 'newrelic_rpm'
gem 'pg'
gem 'pg_search', '~> 0.7.2'
gem 'rack-cors', require: 'rack/cors'
gem 'simple_form', '~> 3.0'
gem 'slim', '~> 2.0'
gem 'sinatra', require: false # for sidekiq monitoring
gem 'sidekiq'
gem 'unf' # For unicode support on Fog/AWS
gem 'virtus'

# Assets
# Needs SASS ~> 3.3, which requires sass-rails ~> 4.0.4 (currently unreleased)
gem 'sass-rails', github: 'rails/sass-rails', branch: 'master'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'bourbon', '~> 4.0'
gem 'neat', '~> 1.6'
gem 'font-awesome-rails', '~> 4.0'

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'foreman'
  gem 'forgery'
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'rspec-rails', '~> 3.0'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'codeclimate-test-reporter', require: false
  gem 'database_cleaner'
  gem 'vcr'
  gem 'webmock'
  gem 'with_model'

  # Require Simplecov explicitly. Remove this explicit dependency when
  # the following is fixed: https://github.com/colszowka/simplecov/issues/281
  gem 'simplecov', require: false, github: 'colszowka/simplecov'
end
