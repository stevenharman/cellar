require 'models/stock_order_receipt'

describe StockOrderReceipt do
  subject(:receipt) { described_class.new(order, beers) }
  let(:order) { double('StockOrder', valid?: true) }
  let(:beers) { [double('Beer', valid?: true)] }

  context 'with valid order and valid beers' do
    it 'is valid' do
      expect(receipt.valid?).to be_true
    end
  end

  context 'with invalid order' do
    let(:order) { double('StockOrder', valid?: false) }

    it 'is invalid' do
      expect(receipt.valid?).to be_false
    end
  end

  context 'with at least one invalid beer' do
    let(:beers) { [double(valid?: true), double(valid?: false)] }

    it 'is invalid' do
      expect(receipt.valid?).to be_false
    end
  end

end
