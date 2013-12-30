require 'models/import/agent'

describe Import::Agent do
  subject(:agent) { described_class.new(match_order, match_maker: match_maker) }
  let(:match_order) { double('Import::MatchOrder', spreadsheet: [row_1], add_to_ledger: true, done: true) }
  let(:match_maker) { double('Search::MatchMaker') }

  describe 'matching beers in a ledger' do
    let(:batch) { double('Batch').as_null_object }
    let(:match_1) { double('BrewMatch') }
    let(:row_1) { {brewery: 'Founders', brew: 'KBS'} }

    before do
      allow(Batch).to receive(:run).and_yield(batch)
      allow(match_maker).to receive(:find_brew).with('Founders KBS') { match_1 }
    end

    it 'addes a match to the ledger for each row in the spreadsheet' do
      expect(match_order).to receive(:add_to_ledger).with(match: match_1, row: row_1)
      agent.match
    end

    it 'cancels the batch if the match cannot be added' do
      allow(match_order).to receive(:add_to_ledger) { false }
      expect(batch).to receive(:cancel)
      agent.match
    end

    it 'marks the match order as done' do
      expect(match_order).to receive(:done)
      agent.match
    end
  end

end
