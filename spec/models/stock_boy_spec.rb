require 'models/stock_boy'

describe StockBoy do
  subject { described_class.new(warehouse, log) }
  let(:warehouse) { stub('Warehouse') }
  let(:log) { stub('InventoryLogger') }

  describe '#inventory' do
    let(:categories) { [stub('Category #1'), stub('Category #2')] }
    let(:styles) { [stub('Style #1'), stub('Style #2')] }
    let(:breweries) { [stub('Brewery #1'), stub('Brewery #2')] }
    before do
      warehouse.stub(:categories) { categories }
      warehouse.stub(:breweries) { breweries }
      warehouse.stub(:styles) { styles }
      CategorySnapshot.stub(:stock)
      StyleSnapshot.stub(:stock)
      BrewerySnapshot.stub(:stock)
      log.stub(:record)
    end

    it 'stocks categories from the warehouse' do
      CategorySnapshot.should_receive(:stock).with(categories.first)
      CategorySnapshot.should_receive(:stock).with(categories.last)
      subject.inventory
    end

    it 'stocks styles from the warehouse' do
      StyleSnapshot.should_receive(:stock).with(styles.first)
      StyleSnapshot.should_receive(:stock).with(styles.last)
      subject.inventory
    end

    it 'stocks breweries from the warehouse' do
      BrewerySnapshot.should_receive(:stock).with(breweries.first)
      BrewerySnapshot.should_receive(:stock).with(breweries.last)
      subject.inventory
    end

    it 'tracks the inventory in the log' do
      log.should_receive(:record).exactly(6).times
      subject.inventory
    end
  end
end
