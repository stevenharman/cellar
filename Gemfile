source :rubygems

ruby '1.9.3'
gem 'rails', '3.2.9'
gem 'jquery-rails'
gem 'thin'
gem 'brewery_db', git: 'https://github.com/brewdega/brewery_db.git', branch: 'basic_webhook_support'
gem 'devise', '~> 2.1'
gem 'draper'
gem 'kaminari'
gem 'pg'
gem 'pg_search'
gem 'simple_form'
gem 'slim'
gem 'sidekiq'
gem 'sinatra', :require => nil # for sidekiq monitoring

group :assets do
  gem 'sass-rails', '~> 3.1'
  gem 'bootstrap-sass', '~> 2.1.0'
  gem 'font-awesome-sass-rails'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '>= 1.0.3'
end

group :test do
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'with_model'
  gem 'shoulda-matchers'
  gem 'simplecov', :require => false
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
  gem 'rspec-rails', '~> 2.6'
end

