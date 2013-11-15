require 'sidekiq'

module Import
  class MatchJob
    include Sidekiq::Worker

    attr_reader :agent, :ledgers

    def self.match(import_ledger)
      jid = perform_async(import_ledger.id)
      import_ledger.attach_job(jid)
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
