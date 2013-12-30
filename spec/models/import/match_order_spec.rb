require 'models/import/match_order'

describe Import::MatchOrder do
  subject(:order) { described_class.new(import_ledger, candidate_factory: candidate_factory) }
  let(:import_ledger) { double('Import::Ledger') }
  let(:candidate_factory) { double('Import::CandidateBeer') }

  describe 'submitting a new order' do
    it 'marks the order as pending when the MatchJob can be fulfilled' do
      allow(Import::MatchJob).to receive(:fulfill).with(order) { 'a-job-id' }
      expect(import_ledger).to receive(:update_match_order_status).with(:pending)
      expect(import_ledger).not_to receive(:update_match_order_status).with(:new)
      order.submit
    end

    it 'resets the order to new when the MatchJob cannot be fulfilled' do
      allow(Import::MatchJob).to receive(:fulfill).with(order) { nil }
      expect(import_ledger).to receive(:update_match_order_status).with(:pending)
      expect(import_ledger).to receive(:update_match_order_status).with(:new)
      order.submit
    end
  end

  it 'is pending when the ledger has a match order status of pending' do
    allow(import_ledger).to receive(:match_order_status) { 'new' }
    expect(order).not_to be_pending

    allow(import_ledger).to receive(:match_order_status) { 'pending' }
    expect(order).to be_pending
  end

  describe 'adding a matching row to the order' do
    let(:candiate_beer) { double('a CandidateBeer') }
    let(:match) { double('Import::BrewMatch') }
    let(:row) { Hash.new }

    it 'adds a candidate beer to the ledger' do
      allow(candidate_factory).to receive(:build).with(match: match, row: row) { candiate_beer }
      expect(import_ledger).to receive(:add_candidate).with(candiate_beer)
      order.add_to_ledger(match: match, row: row)
    end
  end
end
