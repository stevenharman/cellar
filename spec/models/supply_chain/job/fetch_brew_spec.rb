require 'models/supply_chain/job/fetch_brew'

describe SupplyChain::Job::FetchBrew do

  describe '.fulfill' do
    let(:order) { stub('Order', attribute_id: 'abc123') }

    it 'fulfills fetch orders for brew' do
      order.stub(fetch_brew?: true)

      described_class.should_receive(:perform_async).with(order.attribute_id)
      described_class.fulfill(order)
    end

    it 'does nothing for non-brew fetch orders' do
      order.stub(fetch_brew?: false)

      described_class.should_not_receive(:perform_async)
      described_class.fulfill(order)
    end
  end
end
