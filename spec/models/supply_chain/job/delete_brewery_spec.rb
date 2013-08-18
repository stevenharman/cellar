require 'active_record_spec_helper'
require 'models/supply_chain/job/delete_brewery'
require 'models/supply_chain/order'

describe SupplyChain::Job::DeleteBrewery do

  describe '.fulfill' do
    subject(:job) { described_class }

    it 'fulfills orders for a deleted brewery' do
      order = build_order(attribute: 'brewery', action: 'delete', attributeId: 'abc123')

      expect(job).to receive(:perform_async).with('abc123')
      job.fulfill(order)
    end

    it 'does nothing for non-brewery orders' do
      order = build_order(attribute: 'not-brewery', action: 'delete', attributeId: 'abc123')

      expect(job).not_to receive(:perform_async)
      job.fulfill(order)
    end

    it 'does nothing for non-delete orders' do
      order = build_order(attribute: 'brewery', action: 'foo', attributeId: 'abc123')

      expect(job).not_to receive(:perform_async)
      job.fulfill(order)
    end

    def build_order(args)
      SupplyChain::Order.new(args)
    end
  end

  describe '#perform' do
    subject(:job) { described_class.new(fake_brewery_factory) }
    let(:brewery) { double('a Brewery') }
    let(:fake_brewery_factory) { double('Brewery') }

    it 'cleans up the brewery' do
      allow(fake_brewery_factory).to receive(:find_by_brewery_db_id!).with('abc123') { brewery }
      expect(CleanUp).to receive(:brewery).with(brewery)
      job.perform('abc123')
    end

    context 'when the brewery does not exist' do
      require 'models/brewery'

      subject(:job) { described_class.new }

      it 'fails with meaningful error' do
        expect(CleanUp).not_to receive(:brewery)
        expect { job.perform('abc123') }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end

