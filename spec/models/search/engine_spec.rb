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

  it 'pages the results' do
    result = double('PGSearch Result')
    PgSearch.stub_chain(:multisearch, :includes) { result }
    result.should_receive(:page).with(42)

    search_engine.search(Search::Query.new(terms: 'hi', page: 42))
  end

  it 'does not search for an empty query' do
    PgSearch.should_not_receive(:multisearch)
    results = search_engine.search(Search::Query.new(terms: ''))
    expect(results.total_count).to eq(0)
    expect(results.current_page).to eq(1)
  end

  it 'does not search for a nil query' do
    PgSearch.should_not_receive(:multisearch)
    results = search_engine.search(Search::Query.new(terms: nil))
    expect(results.total_count).to eq(0)
    expect(results.current_page).to eq(1)
  end
end
