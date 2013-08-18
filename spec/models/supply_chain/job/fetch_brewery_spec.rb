require 'models/supply_chain/job/fetch_brewery'

describe SupplyChain::Job::FetchBrewery do
  subject(:job) { described_class }

  describe '.fulfill' do
    let(:order) { double('Order', attribute_id: 'abc123') }

    it 'fulfills fetch orders for brewery' do
      allow(order).to receive(:fetch_brewery?) { true }

      expect(job).to receive(:perform_async).with(order.attribute_id)
      job.fulfill(order)
    end

    it 'does nothing for non-brewery fetch orders' do
      allow(order).to receive(:fetch_brewery?) { false }

      expect(job).not_to receive(:perform_async).with(order.attribute_id)
      job.fulfill(order)
    end
  end
end

