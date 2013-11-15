require 'sidekiq'

module Import
  class MatchJob
    include Sidekiq::Worker

    attr_reader :agent, :ledgers, :match_orders

    def self.fulfill(match_order)
      perform_async(match_order.ledger_id)
    end

    def initialize(agent: Agent, ledgers: Ledger, match_orders: MatchOrder)
      @agent = agent
      @ledgers = ledgers
      @match_orders = match_orders
    end

    def perform(import_ledger_id)
      ledger = ledgers.find(import_ledger_id)
      match_order = match_orders.find_by(ledger)
      agent.match(match_order)
    end
  end
end
