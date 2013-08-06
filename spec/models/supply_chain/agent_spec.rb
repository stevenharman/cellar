require 'spec_helper'

describe SupplyChain::Agent, :vcr do
  subject { described_class.new(warehouse, log) }
  let(:warehouse) { SupplyChain::Warehouse.new }
  let(:log) { SupplyChain::Log::Noop.new }
  let(:raw_data) { double }

  it '#import_reference_data loads the all styles and their categories', :slow do
    subject.import_reference_data
    expect(Style.count).to eq(157)
    expect(Category.count).to eq(12)
    expect(BrewAvailability.count).to eq(8)
  end

  it '#import_brewery loads the brewery', :slow do
    subject.import_brewery('Idm5Y5')
    expect(Brewery.count).to eq(1)

    brewery = Brewery.first
    expect(brewery.brewery_db_id).to eq('Idm5Y5')
    expect(brewery.brewery_db_status).to eq('verified')
  end

  describe '#import_brew' do
    it 'loads the brew for all collaborating breweries' do
      alpine = subject.import_brewery('vDxSPd')
      new_belgium = subject.import_brewery('Jt43j7')

      brew = subject.import_brew('aapeRv')
      expect(Brew.count).to eq(1)
      expect(brew.brewery_db_id).to eq('aapeRv')
      expect(brew.brewery_db_status).to eq('verified')
      expect(brew.breweries).to eq([alpine, new_belgium])
      expect(alpine.brews).to eq([brew])
      expect(new_belgium.brews).to eq([brew])
    end

    it 'does not duplicate breweries when re-imported' do
      alpine = subject.import_brewery('vDxSPd')
      subject.import_brew('aapeRv')

      new_belgium = subject.import_brewery('Jt43j7')
      brew = subject.import_brew('aapeRv')
      expect(Brew.count).to eq(1)
      expect(brew.breweries).to eq([alpine, new_belgium])
      expect(alpine.brews).to eq([brew])
      expect(new_belgium.brews).to eq([brew])
    end
  end
end
