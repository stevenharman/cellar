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
    let(:a_batch) { double('Batch').as_null_object }
    before do
      Batch.stub(:run).and_yield(a_batch)
      brew_master.stub(:process).with(order) { [beer, beer] }
    end

    context 'with a valid order' do
      let(:order) { double('StockOrder', valid?: true, brew: brew) }

      it 'adds the beer to the cellar' do
        clerk.procure(order)
        expect(cellar).to have_received(:add).with(beer).twice
        expect(a_batch).to_not have_received(:cancel)
      end

      it 'calculates the inventory for the cellar and brew' do
        clerk.procure(order)
        expect(inventory_report).to have_received(:calculate).with(brew)
      end

      it 'cancels the batch if any beer fails to be added' do
        cellar.stub(:add).and_return(true, false)
        expect(a_batch).to receive(:cancel)
        clerk.procure(order)
      end
    end

    context 'with an invalid order' do
      let(:order) { double('StockOrder', valid?: false, brew: brew) }

      it 'does not procure the beers' do
        clerk.procure(order)
        expect(brew_master).to_not have_received(:process)
        expect(cellar).to_not have_received(:add)
        expect(inventory_report).to_not have_received(:calculate)
      end
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
