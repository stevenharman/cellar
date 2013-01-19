require 'spec_helper'

describe SupplyChain::Job::FetchBrewCatalog do
  describe '.perform' do
    let(:catalog) { described_class.new(warehouse, log) }
    let(:warehouse) { SupplyChain::Warehouse.new }
    let(:log) { SupplyChain::Log::Noop.new  }
    let!(:brewery) { FactoryGirl.create(:brewery, brewery_db_id: 'Idm5Y5') }

    it 'imports the brews from the brewery', :slow, vcr: { record: :once } do
      brews = catalog.perform('Idm5Y5')
      expect(brewery.brews.size).to eq(brews.size)
    end
  end

  describe '.fulfill' do
    let(:order) { stub('Order', attribute_id: 'abc123') }

    it 'fulfills orders for brew_catalog' do
      order.stub(fetch_brew_catalog?: true)

      described_class.should_receive(:perform_async).with(order.attribute_id)
      described_class.fulfill(order)
    end

    it 'does nothing for non-brew_catalog orders' do
      order.stub(fetch_brew_catalog?: false)

      described_class.should_not_receive(:perform_async)
      described_class.fulfill(order)
    end
  end
end
