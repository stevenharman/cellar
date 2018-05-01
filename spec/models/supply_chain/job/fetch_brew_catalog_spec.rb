require 'spec_helper'

describe SupplyChain::Job::FetchBrewCatalog do
  describe '.perform' do
    subject(:job) { described_class.new(warehouse, log) }
    let(:warehouse) { SupplyChain::Warehouse.new }
    let(:log) { SupplyChain::Log::Noop.new  }
    let!(:brewery) { FactoryBot.create(:brewery, brewery_db_id: 'Idm5Y5') }

    it 'imports the brews from the brewery', :slow, vcr: { record: :once } do
      brews = job.perform('Idm5Y5')
      expect(brewery.brews.size).to eq(brews.size)
    end
  end

  describe '.fulfill' do
    subject(:job) { described_class }
    let(:order) { double('Order', attribute_id: 'abc123') }

    it 'fulfills orders for brew_catalog' do
      allow(order).to receive(:fetch_brew_catalog?) { true }

      expect(job).to receive(:perform_async).with(order.attribute_id)
      job.fulfill(order)
    end

    it 'does nothing for non-brew_catalog orders' do
      allow(order).to receive(:fetch_brew_catalog?) { false }

      expect(job).not_to receive(:perform_async)
      job.fulfill(order)
    end
  end
end
