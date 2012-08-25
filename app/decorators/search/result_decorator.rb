require 'delegate'
require_relative 'brew_decorator'
require_relative 'brewery_decorator'

module Search
class ResultDecorator < SimpleDelegator
  include Enumerable

  def initialize(search_result)
    @search_result = search_result
    super(@search_result)
  end

  def each(&block)
    return super unless block

    @search_result.each do |r|
      block.call(decorate_result(r))
    end
  end

  private

  def decorate_result(thing)
    decorator = result_decorators.fetch(thing.class) { :no_decorator_exists }
    decorator.new(thing)
  end

  def result_decorators
    @result_decorators ||= { Brew => Search::BrewDecorator,
                             Brewery => Search::BreweryDecorator }
  end
end
end
