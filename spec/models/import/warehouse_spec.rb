require 'vcr_spec_helper'
require 'models/import/warehouse'

describe Import::Warehouse do
  subject { described_class.new }

  it 'fetches categories from BreweryDB', :vcr do
    categories = subject.categories
    expect(categories.first.id).to be_kind_of Fixnum
    expect(categories.each).to be_kind_of Enumerator
    expect(categories.count).to eq(12)
  end

  it 'fetches styles from BreweryDB', :vcr do
    styles = subject.styles
    expect(styles.first.id).to be_kind_of Fixnum
    expect(styles.first.category_id).to be_kind_of Fixnum
    expect(styles.each).to be_kind_of Enumerator
    expect(styles.count).to eq(157)
  end

  it 'fetches breweries from BreweryDB', :vcr do
    breweries = subject.breweries
    expect(breweries.first.id).to be_kind_of String
    expect(breweries.each).to be_kind_of Enumerator
    #TODO: use #count as soon as it's implemented.
    expect(breweries.count).to eq(3884)
  end

  it 'fetches a single brewery', :vcr do
    brewery = subject.brewery('Idm5Y5')
    expect(brewery.id).to eq('Idm5Y5')
  end

  it "fetches a brewery's beers", :vcr do
    brews = subject.brews_for_brewery('Idm5Y5')
    expect(brews.first.id).to be_kind_of String
    expect(brews.each).to be_kind_of Enumerator
    expect(brews.count).to eq(22)
  end

  it 'fetches a brew', :vcr do
    brew = subject.brew('VvFIVD')
    expect(brew.id).to eq('VvFIVD')
    expect(brew.name).to eq('Hopslam Ale')
  end

  context 'no results from the server' do
    let(:client) { BreweryDB::Client.any_instance }

    it 'fetchs an empty list of categories rather than nil' do
      client.stub_chain(:categories, :all) { nil }
      expect(subject.categories).to be_empty
    end

    it 'fetchs an empty list of styles rather than nil' do
      client.stub_chain(:styles, :all) { nil }
      expect(subject.styles).to be_empty
    end

    it 'fetchs an empty list of breweries rather than nil' do
      client.stub_chain(:breweries, :all) { nil }
      expect(subject.breweries).to be_empty
    end

    it 'fetches an empty list of beers rather than a nil' do
      client.stub_chain(:brewery, :beers) { nil }
      expect(subject.brews_for_brewery('Idm5Y5')).to be_empty
    end
  end
end
