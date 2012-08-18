require 'spec_helper'

describe Import::Agent, :vcr do
  subject { described_class.new(warehouse, log) }
  let(:warehouse) { Import::Warehouse.new }
  let(:log) { Import::Log::Noop.new }
  let(:raw_data) { stub }

  it '#import_styles_with_categories loads the all styles and their categories' do
    subject.import_styles_with_categories
    expect(Style.count).to eq(157)
    expect(Category.count).to eq(12)
  end

  it '#import_breweries loads all of the breweries' do
    warehouse.stub(:breweries) { [raw_data] }
    Import::Brewery.should_receive(:import).with(raw_data)
    subject.import_breweries
  end

  it '#import_brewery loads the brewery' do
    subject.import_brewery('Idm5Y5')
    expect(Brewery.count).to eq(1)
    expect(Brewery.first.brewery_db_id).to eq('Idm5Y5')
  end

  describe '#import_brew' do
    it 'loads the brew for all collaborating breweries' do
      alpine = subject.import_brewery('vDxSPd')
      new_belgium = subject.import_brewery('Jt43j7')

      brew = subject.import_brew('aapeRv')
      expect(Brew.count).to eq(1)
      expect(brew.brewery_db_id).to eq('aapeRv')
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
