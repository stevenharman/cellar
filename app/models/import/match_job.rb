require 'sidekiq'

module Import
  class MatchJob
    include Sidekiq::Worker

    attr_reader :agent, :ledgers

    def self.fulfill(match_order)
      perform_async(match_order.ledger_id)
    end

    def initialize(ledgers: Ledger, agent: Agent)
      @ledgers = ledgers
      @agent = agent
    end

    def perform(import_ledger_id)
      ledger = ledgers.find(import_ledger_id)
      agent.match(ledger)
    end
  end
end
