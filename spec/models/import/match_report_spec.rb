require 'models/import/match_report'

describe Import::MatchReport do
  subject(:report) { described_class.new(ledger) }
  let(:ledger) { double('Import::Ledger') }
  let(:match) { double('Import::CandidateBeer') }

  describe 'confirming a match' do
    it 'marks the candidate beer as confirmed' do
      allow(ledger).to receive(:find_candidate).with(1234) { match }
      expect(match).to receive(:confirm) { true }

      report.confirm(1234)
    end
  end

  describe 'updating a match' do
    let(:brew) { double('Brew') }

    it 'changes the candidate beer for the match' do
      allow(ledger).to receive(:find_match).with(1234) { match }
      expect(match).to receive(:update).with(brew: brew)

      report.update_brew(1234, brew)
    end
  end

end
