require 'models/supply_chain/job/fetch_brewery'

describe SupplyChain::Job::FetchBrewery do

  describe '.fulfill' do
    let(:order) { stub('Order', attribute_id: 'abc123') }

    it 'fulfills orders for brewery' do
      order.stub(:brewery?) { true }

      described_class.should_receive(:perform_async).with(order.attribute_id)
      described_class.fulfill(order)
    end

    it 'does nothing for non-brewery orders' do
      order.stub(:brewery?) { false }

      described_class.should_not_receive(:perform_async)
      described_class.fulfill(order)
    end
  end
end

