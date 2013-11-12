require 'active_model'

module Import
  class MatchOrder
    include ActiveModel::Model

    attr_reader :import_ledger

    def self.create(import_ledger)
      MatchJob.match(import_ledger)
      new(import_ledger)
    end

    def initialize(import_ledger)
      @import_ledger = import_ledger
    end

    def pending?
      !!import_ledger.match_job_id
    end

  end
end
