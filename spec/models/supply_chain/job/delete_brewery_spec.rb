require 'models/supply_chain/job/delete_brewery'
require 'models/supply_chain/order'

describe SupplyChain::Job::DeleteBrewery do
  describe '.fulfill' do
    it 'fulfills orders for a deleted brewery' do
      order = build_order(attribute: 'brewery', action: 'delete', attributeId: 'abc123')

      described_class.should_receive(:perform_async).with('abc123')
      described_class.fulfill(order)
    end

    it 'does nothing for non-brewery orders' do
      order = build_order(attribute: 'not-brewery', action: 'delete', attributeId: 'abc123')

      described_class.should_not_receive(:perform_async)
      described_class.fulfill(order)
    end

    it 'does nothing for non-delete orders' do
      order = build_order(attribute: 'brewery', action: 'foo', attributeId: 'abc123')

      described_class.should_not_receive(:perform_async)
      described_class.fulfill(order)
    end

    def build_order(args)
      SupplyChain::Order.new(args)
    end
  end

  describe '#perform' do
    subject(:job) { described_class.new(fake_brewery_factory) }
    let(:brewery) { stub('a Brewery') }
    let(:fake_brewery_factory) { stub('Brewery') }
    before do
      fake_brewery_factory.stub(:find_by_brewery_db_id).with('abc123') { brewery }
    end

    it 'cleans up the brewery' do
      CleanUp.should_receive(:brewery).with(brewery)
      job.perform('abc123')
    end
  end
end

