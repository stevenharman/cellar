require 'models/import/brew_catalog'
require 'sidekiq/testing/inline'

describe Import::BrewCatalog do
  let(:catalog) { described_class.new(warehouse, log) }
  let(:brews) { [stub('Brew 1'), stub('Brew 2')] }
  let(:warehouse) { stub('Inline::Warehouse') }
  let(:log) { stub('Import::Log')  }
  before do
    warehouse.stub(:brews_for_brewery) { brews }
    log.stub(:report)
  end

  it 'imports the brews from the brewery', vcr: { record: :once } do
    Import::Brew.should_receive(:import).with(brews.first)
    Import::Brew.should_receive(:import).with(brews.last)
    catalog.perform('Idm5Y5')
  end
end
