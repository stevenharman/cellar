require 'models/import/match_job'

describe Import::MatchJob do
  subject(:job) { described_class }
  let(:import_ledger) { double('Import::Ledger', id: ledger_id, attach_job: job_id) }
  let(:ledger_id) { 123 }
  let(:job_id) { 'abc123' }

  describe 'creating a new match job for an import ledger' do
    before do
      allow(job).to receive(:perform_async) { job_id }
    end

    it 'enqueues the job' do
      expect(job).to receive(:perform_async).with(ledger_id)
      job.match(import_ledger)
    end

    it 'attaches the job id to the ledger' do
      expect(import_ledger).to receive(:attach_job).with(job_id)
      job.match(import_ledger)
    end
  end

  describe 'matching beers for a ledger' do
    subject(:job) { described_class.new(ledgers: ledgers, agent: agent) }
    let(:ledgers) { double('Import::Ledger') }
    let(:agent) { double('Import::Agent') }

    it 'delegates to the import agent to match the ledger' do
      allow(ledgers).to receive(:find).with(ledger_id) { import_ledger }
      expect(agent).to receive(:match).with(import_ledger)
      job.perform(ledger_id)
    end
  end
end
