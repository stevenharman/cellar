module Import
  class MatchReport
    include ActiveModel::Model

    attr_reader :ledger

    def initialize(ledger)
      @ledger = ledger
    end

    def matches
      ledger.candidate_beers.includes(:brew).order(:created_at)
    end

  end
end
