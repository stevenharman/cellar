source :rubygems

gem 'rails', '3.2.0'
gem 'jquery-rails'
gem 'thin'
gem 'sorcery'
gem 'pg'
gem 'pg_search', git: 'git://github.com/stevenharman/pg_search.git', branch: 'rails-3-2-deprications'
gem 'with_model', git: 'git://github.com/stevenharman/with_model.git', branch: 'rails-3-2-deprecations', group: :test

group :assets do
  gem 'bootstrap-sass', '~> 1.4.4'
  gem 'coffee-rails', "~> 3.2.1"
  gem 'uglifier', ">= 1.0.3"
end

group :development, :test do
  gem 'capybara', git: 'https://github.com/jnicklas/capybara.git'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'foreman'
  gem 'heroku'
  gem 'pry'
  gem 'rspec-rails', '~> 2.6'
  gem 'shoulda-matchers'
  gem 'simplecov', :require => false, :group => :test
end

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

