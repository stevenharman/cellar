require 'active_record_spec_helper'
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
    subject(:job) { described_class.new(fake_brew_factory) }
    let(:brew) { stub('a Brew') }
    let(:fake_brew_factory) { stub('Brew') }

    it 'cleans up the brew' do
      fake_brew_factory.stub(:find_by_brewery_db_id!).with('abc123') { brew }
      CleanUp.should_receive(:brew).with(brew)
      job.perform('abc123')
    end

    context 'when the brew does not exist' do
      subject(:job) { described_class.new }

      it 'fails with meaningful error' do
        CleanUp.should_not_receive(:brew)
        expect { job.perform('abc123') }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
