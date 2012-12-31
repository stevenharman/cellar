require 'models/supply_chain/job/delete_brew'
require 'models/supply_chain/order'

describe SupplyChain::Job::DeleteBrew do
  describe '.fulfill' do
    it 'fulfills orders for a deleted brew' do
      order = build_order(attribute: 'beer', action: 'delete', attributeId: 'abc123')

      described_class.should_receive(:perform_async).with('abc123')
      described_class.fulfill(order)
    end

    it 'does nothing for non-brew orders' do
      order = build_order(attribute: 'not-beer', action: 'delete', attributeId: 'abc123')

      described_class.should_not_receive(:perform_async)
      described_class.fulfill(order)
    end

    it 'does nothing for non-delete orders' do
      order = build_order(attribute: 'beer', action: 'foo', attributeId: 'abc123')

      described_class.should_not_receive(:perform_async)
      described_class.fulfill(order)
    end

    def build_order(args)
      SupplyChain::Order.new(args)
    end
  end

  describe '#perform' do
    subject(:job) { described_class.new }
    let(:brewery_db_id) { 'abc123' }

    it 'cleans up the brew' do
      CleanUp.should_receive(:brew).with(brewery_db_id)
      job.perform(brewery_db_id)
    end
  end
end
