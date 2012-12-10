require 'models/supply_chain/job/fetch_brew'

describe SupplyChain::Job::FetchBrew do

  describe '.fulfill' do
    let(:order) { stub('Order', attribute_id: 'abc123') }

    it 'fulfills orders for brew' do
      order.stub(:brew?) { true }

      described_class.should_receive(:perform_async).with(order.attribute_id)
      described_class.fulfill(order)
    end

    it 'does nothing for non-brew orders' do
      order.stub(:brew?) { false }

      described_class.should_not_receive(:perform_async)
      described_class.fulfill(order)
    end
  end
end
