require 'models/clerk'

describe Clerk do
  subject(:clerk) { described_class.new(cellar, inventory_report, brew_master) }
  let(:cellar) { double('Cellar', add: true) }
  let(:brew_master) { double('BrewMaster') }
  let(:inventory_report) { double('InventoryReport', calculate: nil) }
  let(:order) { double('order', brew: brew) }
  let(:beer) { double('Beer') }
  let(:brew) { double('Brew') }
  let(:a_batch) { double('Batch') }

  describe '#procure' do
    before do
      Batch.stub(:run).and_yield(a_batch)
      brew_master.stub(:process).with(order) { [beer, beer] }
    end

    it 'adds the beer to the cellar' do
      cellar.should_receive(:add).with(beer).twice
      a_batch.should_not_receive(:cancel)
      clerk.procure(order)
    end

    it 'calculates the inventory for the cellar and brew' do
      inventory_report.should_receive(:calculate).with(brew)
      clerk.procure(order)
    end

    it 'cancels the batch if any beer fails to be added' do
      cellar.stub(:add).and_return(true, false)
      a_batch.should_receive(:cancel)
      clerk.procure(order)
    end
  end
end
