require 'vcr_spec_helper'
require 'models/supply_chain/warehouse'

describe SupplyChain::Warehouse do
  subject(:warehouse) { described_class.new }

  describe 'fetching from the API', :vcr do

    it 'fetches categories from BreweryDB' do
      categories = warehouse.categories
      expect(categories.first.id).to be_kind_of Fixnum
      expect(categories.each).to be_kind_of Enumerator
      expect(categories.count).to eq(12)
    end

    it 'fetches styles from BreweryDB' do
      styles = warehouse.styles
      expect(styles.first.id).to be_kind_of Fixnum
      expect(styles.first.category_id).to be_kind_of Fixnum
      expect(styles.each).to be_kind_of Enumerator
      expect(styles.count).to eq(157)
    end

    it 'fetches sizes from BreweryDB' do
      sizes = warehouse.sizes
      expect(sizes.first.id).to be_kind_of Fixnum
      expect(sizes.each).to be_kind_of Enumerator
      expect(sizes.count).to eq(17)
    end

    it 'fetches brew availability from BreweryDB' do
      avails = warehouse.brew_availabilities
      expect(avails.first.id).to be_kind_of Fixnum
      expect(avails.each).to be_kind_of Enumerator
      expect(avails.count).to eq(8)
    end

    it 'fetches breweries from BreweryDB', :slow do
      breweries = warehouse.breweries
      expect(breweries.first.id).to be_kind_of String
      expect(breweries.each).to be_kind_of Enumerator
      expect(breweries.count).to eq(4567)
    end

    it 'fetches a single brewery' do
      brewery = warehouse.brewery('Idm5Y5')
      expect(brewery.id).to eq('Idm5Y5')
    end

    it "fetches a brewery's beers" do
      brews = warehouse.brews_for_brewery('Idm5Y5')
      expect(brews.first.id).to be_kind_of String
      expect(brews.each).to be_kind_of Enumerator
      expect(brews.count).to eq(25)
    end

    it 'fetches a single brew' do
      brew = warehouse.brew('VvFIVD')
      expect(brew.id).to eq('VvFIVD')
      expect(brew.name).to eq('Hopslam Ale')
    end
  end

  context 'no results from the server' do
    let(:client) { BreweryDB::Client.any_instance }

    it 'fetchs an empty list of categories rather than nil' do
      client.stub_chain(:categories, :all) { nil }
      expect(warehouse.categories).to be_empty
    end

    it 'fetchs an empty list of styles rather than nil' do
      client.stub_chain(:styles, :all) { nil }
      expect(warehouse.styles).to be_empty
    end

    it 'fetchs an empty list of sizes rather than nil' do
      client.stub_chain(:fluid_size, :all) { nil }
      expect(warehouse.sizes).to be_empty
    end

    it 'fetchs an empty list of beer availabilities rather than nil' do
      client.stub_chain(:menu, :beer_availability) { nil }
      expect(warehouse.brew_availabilities).to be_empty
    end

    it 'fetchs an empty list of breweries rather than nil' do
      client.stub_chain(:breweries, :all) { nil }
      expect(warehouse.breweries).to be_empty
    end

    it 'fetches an empty list of beers rather than a nil' do
      client.stub_chain(:brewery, :beers) { nil }
      expect(warehouse.brews_for_brewery('Idm5Y5')).to be_empty
    end
  end
end
