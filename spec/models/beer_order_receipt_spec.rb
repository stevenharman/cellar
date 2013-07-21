require 'stock_order_receipt'

describe StockOrderReceipt do
  subject(:receipt) { described_class.new(beers) }

  describe 'all ordered beers were created' do
    let(:beers) { Array.new(4, double(:valid? => true)) }
    specify { receipt.should be_valid }
    specify { receipt.example_beer.should be }
  end

  describe 'at least one beer was bad' do
    let(:beers) { [double(:valid? => true), double(:valid? => false), double(:valid? => true)]}
    specify { receipt.should_not be_valid }
  end
end
