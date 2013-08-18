require 'active_record_spec_helper'
require 'models/supply_chain/job/delete_brew'
require 'models/supply_chain/order'

describe SupplyChain::Job::DeleteBrew do

  describe '.fulfill' do
    subject(:job) { described_class }

    it 'fulfills orders for a deleted brew' do
      order = build_order(attribute: 'beer', action: 'delete', attributeId: 'abc123')

      expect(job).to receive(:perform_async).with('abc123')
      job.fulfill(order)
    end

    it 'does nothing for non-brew orders' do
      order = build_order(attribute: 'not-beer', action: 'delete', attributeId: 'abc123')

      expect(job).not_to receive(:perform_async)
      job.fulfill(order)
    end

    it 'does nothing for non-delete orders' do
      order = build_order(attribute: 'beer', action: 'foo', attributeId: 'abc123')

      expect(job).not_to receive(:perform_async)
      job.fulfill(order)
    end

    def build_order(args)
      SupplyChain::Order.new(args)
    end
  end

  describe '#perform' do
    subject(:job) { described_class.new(fake_brew_factory) }
    let(:brew) { double('a Brew') }
    let(:fake_brew_factory) { double('Brew') }

    it 'cleans up the brew' do
      allow(fake_brew_factory).to receive(:find_by_brewery_db_id!).with('abc123') { brew }
      expect(CleanUp).to receive(:brew).with(brew)
      job.perform('abc123')
    end

    context 'when the brew does not exist' do
      require 'models/brew'
      subject(:job) { described_class.new }

      it 'fails with meaningful error' do
        expect(CleanUp).not_to receive(:brew)
        expect { job.perform('abc123') }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
