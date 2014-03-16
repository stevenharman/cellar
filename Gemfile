source 'https://rubygems.org'

ruby '2.1.1'
gem 'rails', '~> 4.0.4'

# Must be early in Gemfile so it's loaded before libs that depend on ENV Vars
gem 'dotenv-rails', '~> 0.10.0', groups: [:development, :test]

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
gem 'sass-rails', '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'bourbon', git: 'https://github.com/thoughtbot/bourbon.git' # Need ~> 3.2 for retina-image
gem 'neat', git: 'https://github.com/thoughtbot/neat.git' # Need ~> 1.5' when changing above
gem 'font-awesome-rails', '~> 4.0'

# Lock to SASS 3.3 compatible sprockets until sass-rails is fixed
# See: https://github.com/rails/sass-rails/issues/191
gem 'sprockets', '2.11.0'

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'foreman'
  gem 'forgery'
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'rspec-rails', '~> 2.14'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
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
