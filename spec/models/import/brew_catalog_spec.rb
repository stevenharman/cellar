require 'spec_helper'

describe Import::BrewCatalog, :vcr do
  let(:catalog) { described_class.new(warehouse, log) }
  let(:warehouse) { Import::Warehouse.new }
  let(:log) { Import::Log::Noop.new  }
  let!(:brewery) { FactoryGirl.create(:brewery, brewery_db_id: 'Idm5Y5') }

  it 'imports the brews from the brewery', vcr: { record: :once } do
    brews = catalog.perform('Idm5Y5')
    expect(brewery.brews.size).to eq(brews.size)
  end
end
