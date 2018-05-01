require 'spec_helper'
require 'models/beers_from_brewery_query'

describe BeersFromBreweryQuery do
  subject(:query) { described_class.new(brewery) }
  let!(:brewery) { brew.breweries.first }
  let!(:other_beer) { FactoryBot.create(:beer) }
  let(:brew) { FactoryBot.create(:brew) }

  it 'is empty when there are no beers stored for the Brewery' do
    expect(query).to be_empty
  end

  it 'finds all known beers for a brewery, no matter their status' do
    beer1 = FactoryBot.create(:beer, :cellared, brew: brew)
    beer2 = FactoryBot.create(:beer, :drunk, brew: brew)
    beer3 = FactoryBot.create(:beer, :skunked, brew: brew)
    beer4 = FactoryBot.create(:beer, :traded, brew: brew)
    expect(query).to match_array([beer1, beer2, beer3, beer4])
  end
end
