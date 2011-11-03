# Fast specs
# Inspired/stolen from: http://blog.leshill.org/blog/2011/10/23/fast-specs.html
#
# To run from the command line for my_model in your app:
#
#     rspec -Ifast_specs spec_no_rails/models/my_model
#
require 'rspec'

RSpec.configure do |config|
  config.mock_with :rspec
end

# Load required files from the app
#
#   app_require 'app/model/profile'
#
def app_require(file)
  require File.expand_path(file)
end

# Load required support files
#
#   support_require 'database'
#   support_require 'database_cleaner'
#
def support_require(file)
  require "support/#{file}"
end
