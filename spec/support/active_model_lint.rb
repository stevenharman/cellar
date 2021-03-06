# adapted from rspec-rails
# http://github.com/rspec/rspec-rails/blob/master/spec/rspec/rails/mocks/mock_model_spec.rb
# USAGE:
#
#    subject { ModelUnderTest.new(params) }
#    it_behaves_like "ActiveModel"

shared_examples_for 'ActiveModel' do
  require_relative 'minitest_support'
  include MinitestCounters
  require 'minitest/assertions'
  include Minitest::Assertions

  # include `Object#blank?` because it is used deep inside the lint tests, so
  # we need it for isolated tests. #lolrails
  require 'active_support/core_ext/object/blank.rb'
  require 'active_model/lint'
  include ActiveModel::Lint::Tests

  def model
    subject
  end

  ActiveModel::Lint::Tests.public_instance_methods.map(&:to_s).grep(/^test/).each do |method|
    it "#{method.gsub('_', ' ')}" do
      send method
    end
  end
end

