require 'models/import/match_report'

describe Import::MatchReport do
  subject(:report) { described_class.new(ledger) }
  let(:ledger) { double('Import::Ledger') }

  describe 'confirming a match' do
    let(:match) { double('Import::CandidateBeer') }

    it 'marks the candidate beer as confirmed' do
      allow(ledger).to receive(:find_candidate).with(1234) { match }
      expect(match).to receive(:confirm) { true }

      report.confirm(1234)
    end
  end

end
