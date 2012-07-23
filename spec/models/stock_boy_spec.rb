require 'models/stock_boy'

describe StockBoy do
  subject { described_class.new(warehouse) }
  let(:warehouse) { stub('Warehouse') }

  describe '#inventory' do
    let(:brewery_1) { stub('Brewery #1') }
    let(:brewery_2) { stub('Brewery #2') }
    before do
      warehouse.stub(:breweries) { [brewery_1, brewery_2] }
    end

    it 'stocks breweries from the warehouse' do
      BrewerySnapshot.should_receive(:stock).with(brewery_1)
      BrewerySnapshot.should_receive(:stock).with(brewery_2)
      subject.inventory
    end
  end
end
