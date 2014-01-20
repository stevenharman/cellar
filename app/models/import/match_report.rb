require 'active_model'

module Import
  class MatchReport
    include ActiveModel::Model

    attr_reader :ledger

    def initialize(ledger)
      @ledger = ledger
    end

    def confirm(match_id)
      match = ledger.find_candidate(match_id)
      match.confirm
      match
    end

    def matches
      ledger.candidate_beers.includes(:brew).order(:created_at)
    end

  end
end
