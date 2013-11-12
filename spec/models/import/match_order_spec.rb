require 'models/import/match_order'

describe Import::MatchOrder do
  subject(:order) { described_class.new(import_ledger) }
  let(:import_ledger) { double('Import::Ledger') }

  it 'is pending when the ledger has a match job id' do
    allow(import_ledger).to receive(:match_job_id) { 'abc123' }
    expect(order).to be_pending
  end

  it 'is not pending when the ledger has no match job id' do
    allow(import_ledger).to receive(:match_job_id) { nil }
    expect(order).not_to be_pending
  end

end
