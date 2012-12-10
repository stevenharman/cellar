require 'models/supply_chain/job/destroy_brewery'
require 'models/supply_chain/order'

describe SupplyChain::Job::DestroyBrewery do

  describe '.fulfill' do
    let(:order_params) { { attribute_id: 'abc123' } }

    it 'fulfills orders for a deleted brewery' do
      order = order(attribute: 'brewery', action: 'delete')

      described_class.should_receive(:perform_async).with(order.attribute_id)
      described_class.fulfill(order)
    end

    it 'does nothing for non-brewery orders' do
      order = order(attribute: 'not-brewery', action: 'delete')

      described_class.should_not_receive(:perform_async)
      described_class.fulfill(order)
    end

    it 'does nothing for non-delete orders' do
      order = order(attribute: 'brewery', action: 'foo')

      described_class.should_not_receive(:perform_async)
      described_class.fulfill(order)
    end

    def order(args)
      SupplyChain::Order.new(args.merge(order_params))
    end
  end
end

