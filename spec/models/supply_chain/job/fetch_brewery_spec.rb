require 'models/supply_chain/job/fetch_brewery'

describe SupplyChain::Job::FetchBrewery do

  describe '.fulfill' do
    let(:order) { double('Order', attribute_id: 'abc123') }

    it 'fulfills fetch orders for brewery' do
      order.stub(:fetch_brewery?) { true }

      described_class.should_receive(:perform_async).with(order.attribute_id)
      described_class.fulfill(order)
    end

    it 'does nothing for non-brewery fetch orders' do
      order.stub(:fetch_brewery?) { false }

      described_class.should_not_receive(:perform_async)
      described_class.fulfill(order)
    end
  end
end

