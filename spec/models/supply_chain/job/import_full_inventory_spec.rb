require 'models/supply_chain/job/import_full_inventory'

describe SupplyChain::Job::ImportFullInventory do
  subject(:job) { described_class.new(warehouse) }
  let(:warehouse) { double('Warehouse') }

  it 'imports the full inventory via an Agent' do
    expect(SupplyChain::Agent).to receive(:import_from).with(warehouse)
    job.perform
  end

end
