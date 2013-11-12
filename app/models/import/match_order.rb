require 'active_model'

module Import
  class MatchOrder
    include ActiveModel::Model

    def self.create(import_ledger)
      new(import_ledger)
    end

    def initialize(import_ledger)
      @import_ledger = import_ledger
    end

    def valid?
    end

  end
end
