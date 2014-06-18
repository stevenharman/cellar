require 'spec_helper'
describe SupplyChain::Agent, :vcr do
  subject(:agent) { described_class.new(warehouse, log) }
  let(:warehouse) { SupplyChain::Warehouse.new }
  let(:log) { SupplyChain::Log::Noop.new }
  let(:raw_data) { double }

  it '#import_reference_data loads the all styles, categories, availability, and sizes', :slow do
    agent.import_reference_data
    expect(Style.count).to eq(160)
    expect(Category.count).to eq(13)
    expect(Availability.count).to eq(8)
    expect(Size.count).to eq(17)
  end

  it '#import_brewery loads the brewery', :slow do
    agent.import_brewery('Idm5Y5')
    expect(Brewery.count).to eq(1)

    brewery = Brewery.first
    expect(brewery.brewery_db_id).to eq('Idm5Y5')
    expect(brewery.brewery_db_status).to eq('verified')
  end

  describe '#import_brew' do
    it 'loads the brew for all collaborating breweries' do
      alpine = agent.import_brewery('vDxSPd')
      new_belgium = agent.import_brewery('Jt43j7')

      brew = agent.import_brew('aapeRv')
      expect(Brew.count).to eq(1)
      expect(brew.brewery_db_id).to eq('aapeRv')
      expect(brew.brewery_db_status).to eq('verified')
      expect(brew.breweries).to eq([alpine, new_belgium])
      expect(alpine.brews).to eq([brew])
      expect(new_belgium.brews).to eq([brew])
    end

    it 'does not duplicate breweries when re-imported' do
      alpine = agent.import_brewery('vDxSPd')
      agent.import_brew('aapeRv')

      new_belgium = agent.import_brewery('Jt43j7')
      brew = agent.import_brew('aapeRv')
      expect(Brew.count).to eq(1)
      expect(brew.breweries).to eq([alpine, new_belgium])
      expect(alpine.brews).to eq([brew])
      expect(new_belgium.brews).to eq([brew])
    end
  end
end
