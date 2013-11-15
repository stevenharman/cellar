require 'active_model'
require_relative 'match_job'

module Import
  class MatchOrder
    include ActiveModel::Model

    attr_reader :import_ledger

    def self.find_by(import_ledger)
      new(import_ledger)
    end

    def self.create(import_ledger)
      find_by(import_ledger).prepare do |order|
        MatchJob.fulfill(order)
      end
    end

    def initialize(import_ledger)
      @import_ledger = import_ledger
    end

    def ledger_id
      import_ledger.id
    end

    def prepare(&block)
      update_status(:new)
      block.call(self)
      update_status(:pending)
      self
    end

    def pending?
      status == 'pending'
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
