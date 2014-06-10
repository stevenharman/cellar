require 'spec_helper'

describe Search::Engine do
  subject(:search_engine) { described_class }
  let(:founders) { FactoryGirl.create(:brewery, name: 'Founders Brewing Company') }

  it 'finds both breweries and brews' do
    founders_brew = FactoryGirl.create(:brew, breweries: [founders])
    query = Search::Query.new(terms: 'founders')
    results = search_engine.search(query)

    expect(results).to include(founders)
    expect(results).to include(founders_brew)
  end

  it 'finds brews with matching names' do
    red_rye = FactoryGirl.create(:brew, breweries: [founders], name: 'Red Rye Ale')
    query = Search::Query.new(terms: 'red rye')
    results = search_engine.search(query)

    expect(results).not_to include(founders)
    expect(results).to include(red_rye)
  end

  it 'filters results when a document type is given' do
    bfast_stout = FactoryGirl.create(:brew, breweries: [founders], name: 'Kentucky Breakfast Stout')
    stout_brewery = FactoryGirl.create(:brewery, name: 'Stout Founders Brewing')
    query = Search::BrewQuery.new(terms: 'Founders Stout')
    results = search_engine.search(query)

    expect(results).to include(bfast_stout)
    expect(results).not_to include(founders)
    expect(results).not_to include(stout_brewery)
  end

  it 'pages the results when a paged query is used' do
    results = double('PGSearch Result')
    PgSearch.stub_chain(:multisearch, :includes) { results }
    expect(results).to receive(:page).with(42)

    search_engine.search(Search::Query.new(terms: 'hi', page: 42))
  end

  it 'does not search for an empty query' do
    expect(PgSearch).not_to receive(:multisearch)
    results = search_engine.search(Search::Query.new(terms: ''))
    expect(results.total_count).to eq(0)
    expect(results.current_page).to eq(1)
  end

  it 'does not search for a nil query' do
    expect(PgSearch).not_to receive(:multisearch)
    results = search_engine.search(Search::Query.new(terms: nil))
    expect(results.total_count).to eq(0)
    expect(results.current_page).to eq(1)
  end

  context 'beers with accents in their name' do
    let(:fantome) { FactoryGirl.create(:brewery, name: 'Brasserie Fantôme') }
    let!(:primtemps) { FactoryGirl.create(:brew, breweries: [fantome], name: "Saison D'Erezée - Printemps") }

    it 'ignores accents in names' do
      query = Search::Query.new(terms: 'Fantôme')
      results = search_engine.search(query)

      expect(results).to include(fantome)
      expect(results).to include(primtemps)
    end

    it 'finds slightly-misspelled beers' do
      query = Search::Query.new(terms: 'Fantôme Siaison Pintemps')
      results = search_engine.search(query)

      expect(results).to include(primtemps)
    end
  end
end
