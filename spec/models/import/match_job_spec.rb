require 'models/import/match_job'

describe Import::MatchJob do
  subject(:job) { described_class }
  let(:import_ledger) { double('Import::Ledger', id: ledger_id) }
  let(:ledger_id) { 123 }

  describe 'creating a new match job for an import ledger' do
    let(:match_order) { double('Import::MatchOrder', ledger_id: ledger_id) }

    it 'enqueues the job' do
      expect(job).to receive(:perform_async).with(ledger_id)
      job.fulfill(match_order)
    end
  end

  describe 'matching beers for a ledger' do
    subject(:job) { described_class.new(agent: agent, ledgers: ledgers, match_orders: match_orders) }
    let(:agent) { double('Import::Agent') }
    let(:ledgers) { double('Import::Ledger') }
    let(:match_orders) { double('Import::MatchOrder') }
    let(:order) { double('Import::MatchOrder') }

    it 'delegates to the import agent to match the ledger' do
      allow(ledgers).to receive(:find).with(ledger_id) { import_ledger }
      allow(match_orders).to receive(:find_by).with(import_ledger) { order }
      expect(agent).to receive(:match).with(order)
      job.perform(ledger_id)
    end
  end
end
