require 'models/supply_chain/job/import_reference_data'

describe SupplyChain::Job::ImportReferenceData do
  subject(:job) { described_class.new(warehouse) }
  let(:warehouse) { double('Warehouse') }
  let(:an_agent) { double('Agent') }
  before do
    allow(SupplyChain::Agent).to receive(:new).with(warehouse) { an_agent }
  end

  it 'imports the Brewery DB reference data via an Agent' do
    expect(an_agent).to receive(:import_reference_data)
    job.perform
  end

end

