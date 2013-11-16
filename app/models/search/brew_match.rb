module Search
  class BrewMatch
    attr_reader :results

    CONFIDENCE_LEVELS = { 0 => :none, 1 => :high }.freeze

    def initialize(results)
      @results = results
    end

    def candidate
      @candidate ||= results.first
    end

    def confidence
      CONFIDENCE_LEVELS.fetch(results.count) { :medium }
    end
  end
end
