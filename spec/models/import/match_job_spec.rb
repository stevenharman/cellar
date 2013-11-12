require 'models/import/match_job'

describe Import::MatchJob do
  subject(:job) { described_class }

  describe 'creating a new match job for an import ledger' do
    let(:import_ledger) { double('Import::Ledger', id: ledger_id, attach_job: true) }
    let(:ledger_id) { 123 }
    let(:job_id) { 'abc123' }

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

end
