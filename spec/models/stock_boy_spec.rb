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
      Import::Category.stub(:import)
      Import::Style.stub(:import)
      Import::Brewery.stub(:import)
      log.stub(:record)
    end

    it 'stocks categories from the warehouse' do
      Import::Category.should_receive(:import).with(categories.first)
      Import::Category.should_receive(:import).with(categories.last)
      subject.inventory
    end

    it 'stocks styles from the warehouse' do
      Import::Style.should_receive(:import).with(styles.first)
      Import::Style.should_receive(:import).with(styles.last)
      subject.inventory
    end

    it 'stocks breweries from the warehouse' do
      Import::Brewery.should_receive(:import).with(breweries.first)
      Import::Brewery.should_receive(:import).with(breweries.last)
      subject.inventory
    end

    it 'tracks the inventory in the log' do
      log.should_receive(:record).exactly(6).times
      subject.inventory
    end
  end
end
