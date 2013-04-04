require 'models/clerk'
require 'models/distribution_order'

describe Clerk do
  subject(:clerk) { described_class.new(cellar, inventory_report, brew_master) }
  let(:cellar) { double('Cellar', add: true) }
  let(:brew_master) { double('BrewMaster') }
  let(:inventory_report) { double('InventoryReport', calculate: nil) }
  let(:beer) { double('Beer', id: 42, brew: brew) }
  let(:brew) { double('Brew') }

  describe '#procure' do
    let(:order) { double('BeerOrder', brew: brew) }
    let(:a_batch) { double('Batch') }
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

  describe '#distribute' do
    let(:order) { DistributionOrder.new(beer_id: beer.id, status: 'traded') }
    before do
      cellar.stub(:update).with(order.beer_id, order.status) { beer }
    end

    it 'reissues the order for the updated beer' do
      reissue = clerk.distribute(order)
      expect(reissue.brew).to eq(brew)
    end

    it 'calculates the inventory for the cellar and brew' do
      inventory_report.should_receive(:calculate).with(brew)
      clerk.distribute(order)
    end
  end
end
