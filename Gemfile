source 'https://rubygems.org'

ruby '2.5.5'
gem 'rails', '~> 4.2.0'

# Must be early in Gemfile so it's loaded before libs that depend on ENV Vars
gem 'dotenv-rails', '~> 2.0', groups: [:development, :test]

gem 'puma'
gem 'pg', '~> 0.21' # Cannot got to PG >= 1.0 until Rails 5.2
gem 'pg_search', '~> 0.7.2'

gem 'active_model_serializers', '~> 0.9.3'
gem 'brewery_db', '~> 0.2.0'
gem 'carrierwave', '~> 1.2'
gem 'devise', '~> 4.7'
gem 'draper', git: 'https://github.com/stevenharman/draper.git', branch: 'compatibility_with_active_model_serializers_next'
gem 'fog-aws'
gem 'kaminari'
gem 'newrelic_rpm'
gem 'rack-cors', require: 'rack/cors'
gem 'responders', '~> 2.0'
gem 'simple_form', '~> 3.0'
gem 'slim', '~> 3.0'
gem 'sidekiq'
gem 'redis-namespace'
gem 'unf' # For unicode support on Fog/AWS
gem 'virtus'

# Assets
# Needs SASS ~> 3.3, which requires sass-rails ~> 4.0.4 (currently unreleased)
gem 'sass-rails', '~> 5.0'
# Lock to sprockets < 3.0 as it seems to break template and/or SASS rendering?
gem 'sprockets', '~> 2.12'
gem 'coffee-rails', '~> 4.1.0'
gem 'uglifier', '>= 1.3.0'
gem 'bourbon', '~> 4.0'
gem 'neat', '~> 1.6'
gem 'font-awesome-rails', '~> 4.0'

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'factory_bot_rails'
  gem 'forgery'
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'rspec-rails', '~> 3.0'
end

group :development do
  gem 'web-console', '~> 3.0'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'simplecov', require: false
  gem 'vcr'
  gem 'webmock'
  gem 'with_model'
end
