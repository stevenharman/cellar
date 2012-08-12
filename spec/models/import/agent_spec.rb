require 'models/import/agent'

describe Import::Agent do
  subject { described_class.new(warehouse, log) }
  let(:warehouse) { stub('Import::Warehouse') }
  let(:log) { stub('Import::Log') }

  describe '#perform' do
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
      Import::BrewCatalog.stub(:import_from)
      log.stub(:record)
    end

    it 'stocks categories from the warehouse' do
      Import::Category.should_receive(:import).with(categories.first)
      Import::Category.should_receive(:import).with(categories.last)
      subject.perform
    end

    it 'stocks styles from the warehouse' do
      Import::Style.should_receive(:import).with(styles.first)
      Import::Style.should_receive(:import).with(styles.last)
      subject.perform
    end

    it 'stocks breweries from the warehouse' do
      Import::Brewery.should_receive(:import).with(breweries.first)
      Import::Brewery.should_receive(:import).with(breweries.last)
      subject.perform
    end

    it 'imports brews for the brewery' do
      Import::BrewCatalog.should_receive(:import_from).twice
      subject.perform
    end

    it 'tracks the imports in the log' do
      log.should_receive(:record).exactly(6).times
      subject.perform
    end
  end
end
