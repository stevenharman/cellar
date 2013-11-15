require 'models/import/match_order'

describe Import::MatchOrder do
  subject(:order) { described_class.new(import_ledger) }
  let(:import_ledger) { double('Import::Ledger', id: 123) }

  describe 'creating a new order' do
    subject(:order_facade) { described_class }
    before do
      allow(order_facade).to receive(:find_by).with(import_ledger) { order }
      allow(order).to receive(:prepare).and_yield(order)
    end

    it 'delegates to MatchJob to fulfill the order' do
      expect(Import::MatchJob).to receive(:fulfill).with(order)
      order_facade.create(import_ledger)
    end

  end

  it 'is pending when the ledger has a match order status of pending' do
    allow(import_ledger).to receive(:match_order_status) { 'new' }
    expect(order).not_to be_pending

    allow(import_ledger).to receive(:match_order_status) { 'pending' }
    expect(order).to be_pending
  end

end
