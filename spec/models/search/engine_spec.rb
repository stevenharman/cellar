require 'spec_helper'

describe Search::Engine do
  subject(:search_engine) { described_class }

  it 'finds both breweries and brews' do
    founders_brewing = FactoryGirl.create(:brewery, name: 'Founders Brewing Company')
    founders_ale = FactoryGirl.create(:brew, name: "Founder's Red Rye Ale")
    query = Search::Query.new('founders')
    result = search_engine.search(query)

    expect(result).to include(founders_brewing)
    expect(result).to include(founders_ale)
  end

  it 'finds brews with matching brewery names' do
    founders = FactoryGirl.create(:brewery, name: 'Founders Brewing Company')
    red_rye = FactoryGirl.create(:brew, breweries: [founders])
    query = Search::Query.new('founders')
    result = search_engine.search(query)

    expect(result).to include(founders)
    expect(result).to include(red_rye)
  end

  it 'pages the results' do
    result = double('PGSearch Result')
    PgSearch.stub_chain(:multisearch, :includes) { result }
    result.should_receive(:page).with(42)

    search_engine.search(Search::Query.new('hi', 42))
  end

  it 'does not search for an empty query' do
    PgSearch.should_not_receive(:multisearch)
    result = search_engine.search(Search::Query.new(''))
    expect(result.total_count).to eq(0)
    expect(result.current_page).to eq(1)
  end

  it 'does not search for a nil query' do
    PgSearch.should_not_receive(:multisearch)
    result = search_engine.search(Search::Query.new(nil))
    expect(result.total_count).to eq(0)
    expect(result.current_page).to eq(1)
  end
end
