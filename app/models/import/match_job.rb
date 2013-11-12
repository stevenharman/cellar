require 'sidekiq'

module Import
  class MatchJob
    include Sidekiq::Worker

    def self.match(import_ledger)
      jid = perform_async(import_ledger.id)
      import_ledger.attach_job(jid)
    end

    def perform(import_ledger_id)
    end

  end
end
