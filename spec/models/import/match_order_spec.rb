require 'models/import/match_order'

describe Import::MatchOrder do
  subject(:order) { described_class.new(import_ledger) }
  let(:import_ledger) { double('Import::Ledger') }

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

end
