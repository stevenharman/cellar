require 'spec_helper'

describe Import::Agent, :vcr do
  subject { described_class.new(warehouse, log) }
  let(:warehouse) { Import::Warehouse.new }
  let(:log) { Import::Log.new }

  it '#import_styles_with_categories loads the all styles and their categories' do
    subject.import_styles_with_categories
    expect(Style.count).to eq(157)
    expect(Category.count).to eq(12)
  end

  it '#import_breweries loads all of the breweries' do
    subject.import_breweries
    expect(Brewery.count).to eq(3877)
  end

  it '#import_brewery loads the brewery' do
    subject.import_brewery('Idm5Y5')
    expect(Brewery.count).to eq(1)
    expect(Brewery.first.brewery_db_id).to eq('Idm5Y5')
  end

  it '#import_brew loads the brew for all collaborating breweries' do
    pending 'Re-work breweries -> brews data model'
    alpine = subject.import_brewery('vDxSPd')
    new_belgium = subject.import_brewery('Jt43j7')

    brew = subject.import_brew('aapeRv')
    expect(Brew.count).to eq(1)
    expect(brew.brewery_db_id).to eq('99Uj1n')
    expect(alpine.brews).to include(brew)
    expect(new_belgium.brews).to include(brew)
  end
end
