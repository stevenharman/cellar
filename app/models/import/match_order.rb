require 'active_model'
require_relative 'match_job'

module Import
  class MatchOrder
    include ActiveModel::Model

    STATUSES = %w(new pending done).freeze

    attr_reader :candidate_factory, :import_ledger

    def self.find_by(import_ledger)
      new(import_ledger)
    end

    def self.submit(import_ledger)
      new(import_ledger).submit
    end

    def initialize(import_ledger, candidate_factory: CandidateBeer)
      @import_ledger = import_ledger
      @candidate_factory = candidate_factory
    end

    STATUSES.each do |s|
      define_method("#{s}?") do
        send(:status) == s
      end
    end

    def add_to_ledger(match: match, row: row)
      beer = candidate_factory.build(match: match, row: row)
      import_ledger.add_candidate(beer)
    end

    def accepted?
      pending? || done?
    end

    def done
      update_status(:done)
      self
    end

    def ledger_id
      import_ledger.id
    end

    def spreadsheet
      import_ledger.spreadsheet
    end

    def submit
      update_status(:pending)
      update_status(:new) unless MatchJob.fulfill(self)
      self
    end

    private

    def status
      import_ledger.match_order_status
    end

    def update_status(new_status)
      import_ledger.update_match_order_status(new_status)
    end

  end
end
