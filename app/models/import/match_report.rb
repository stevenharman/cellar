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
      ledger.candidate_beer_matches
    end

    def update_brew(match_id, brew)
      match = ledger.find_match(match_id)
      match.update(brew: brew)
      match
    end

  end
end
