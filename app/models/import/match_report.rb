module Import
  class MatchReport

    attr_reader :ledger

    def initialize(ledger)
      @ledger = ledger
    end

    def matches
      ledger.candidate_beers
    end

  end
end
