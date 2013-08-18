require 'models/supply_chain/job/fetch_brew'

describe SupplyChain::Job::FetchBrew do
  subject(:job) { described_class }

  describe '.fulfill' do
    let(:order) { double('Order', attribute_id: 'abc123') }

    it 'fulfills fetch orders for brew' do
      allow(order).to receive(:fetch_brew?) { true }

      expect(job).to receive(:perform_async).with(order.attribute_id)
      job.fulfill(order)
    end

    it 'does nothing for non-brew fetch orders' do
      allow(order).to receive(:fetch_brew?) { false }

      expect(job).not_to receive(:perform_async).with(order.attribute_id)
      job.fulfill(order)
    end
  end
end
