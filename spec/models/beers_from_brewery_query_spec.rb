require 'spec_helper'
require 'models/beers_from_brewery_query'

describe BeersFromBreweryQuery do
  subject(:query) { described_class.new(brewery) }
  let!(:brewery) { brew.breweries.first }
  let!(:other_beer) { FactoryGirl.create(:beer) }
  let(:brew) { FactoryGirl.create(:brew) }

  it 'is empty when there are no beers stored for the Brewery' do
    expect(query).to be_empty
  end

  it 'finds all known beers for a brewery, no matter their status' do
    beer1 = FactoryGirl.create(:beer, :cellared, brew: brew)
    beer2 = FactoryGirl.create(:beer, :drunk, brew: brew)
    beer3 = FactoryGirl.create(:beer, :skunked, brew: brew)
    beer4 = FactoryGirl.create(:beer, :traded, brew: brew)
    expect(query).to match_array([beer1, beer2, beer3, beer4])
  end
end
