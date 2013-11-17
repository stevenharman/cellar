source 'https://rubygems.org'

ruby '2.0.0'
gem 'rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'puma'
gem 'dotenv-rails', '~> 0.9.0'
gem 'brewery_db', '~> 0.2.0'
gem 'carrierwave', '~> 0.9.0'
gem 'devise', '~> 3.1'
gem 'draper'
gem 'fog', '~> 1.15'
gem 'kaminari'
gem 'newrelic_rpm'
gem 'pg'
gem 'pg_search'
gem 'rack-cors', require: 'rack/cors'
gem 'simple_form', '~> 3.0.0.rc'
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

group :production do
  gem 'rails_12factor'
end

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
