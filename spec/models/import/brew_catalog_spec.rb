require 'models/import/brew_catalog'
require 'sidekiq/testing/inline'

describe Import::BrewCatalog do
  let(:catalog) { described_class.new(warehouse, log) }
  let(:brews) { [Hash.new, Hash.new] }
  let(:warehouse) { stub('Inline::Warehouse') }
  let(:log) { stub('Import::Log')  }
  before do
    warehouse.stub(:brews_for_brewery) { brews }
    log.stub(:record)
  end

  it 'imports the brews from the brewery', vcr: { record: :once } do
    Import::Brew.should_receive(:import).with({brewery_id: 'Idm5Y5'})
    Import::Brew.should_receive(:import).with({brewery_id: 'Idm5Y5'})
    catalog.perform('Idm5Y5')
  end
end
