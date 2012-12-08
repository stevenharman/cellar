require 'spec_helper'

describe SupplyChain::FetchBrewCatalog, :vcr do
  let(:catalog) { described_class.new(warehouse, log) }
  let(:warehouse) { SupplyChain::Warehouse.new }
  let(:log) { SupplyChain::Log::Noop.new  }
  let!(:brewery) { FactoryGirl.create(:brewery, brewery_db_id: 'Idm5Y5') }

  it 'imports the brews from the brewery', vcr: { record: :once } do
    brews = catalog.perform('Idm5Y5')
    expect(brewery.brews.size).to eq(brews.size)
  end

  describe '.fulfill' do
    it 'fulfills orders for brew_catalog' do
      order = OpenStruct.new(attribute: 'brew_catalog', attribute_id: 'abc123')

      described_class.should_receive(:perform_async).with(order.attribute_id)
      described_class.fulfill(order)
    end

    it 'does nothing for non-brew_catalog orders' do
      order = OpenStruct.new(attribute: 'beer', attribute_id: 'abc123')

      described_class.should_not_receive(:perform_async)
      described_class.fulfill(order)
    end
  end
end
