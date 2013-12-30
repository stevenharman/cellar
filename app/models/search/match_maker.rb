require_relative 'engine'
require_relative 'brew_match'
require_relative 'brew_query'

module Search
  class MatchMaker

    attr_reader :query_factory, :match_factory, :engine

    def self.find_brew(query)
      new.find_brew(query)
    end

    def initialize(engine: Engine, match_factory: BrewMatch, query_factory: BrewQuery)
      @engine = engine
      @match_factory = match_factory
      @query_factory = query_factory
    end

    def find_brew(query)
      results = engine.search(prepare(query))
      match_factory.new(results)
    end

    private

    def prepare(query)
      query_factory.new(terms: query)
    end
  end
end
