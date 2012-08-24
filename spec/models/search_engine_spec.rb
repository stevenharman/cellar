require 'spec_helper'

describe SearchEngine do
  subject(:search_engine) { described_class }

  it 'finds both breweries and brews' do
    founders_brewing = FactoryGirl.create(:brewery, name: 'Founders Brewing Company')
    founders_ale = FactoryGirl.create(:brew, name: "Founder's Red Rye Ale")
    query = SearchQuery.new('founders')
    result = search_engine.search(query)

    expect(result).to include(founders_brewing)
    expect(result).to include(founders_ale)
  end

  it 'finds brews with matching brewery names' do
    founders = FactoryGirl.create(:brewery, name: 'Founders Brewing Company')
    red_rye = FactoryGirl.create(:brew, breweries: [founders])
    query = SearchQuery.new('founders')
    result = search_engine.search(query)

    expect(result).to include(founders)
    expect(result).to include(red_rye)
  end

  it 'pages the results' do
    result = stub('PGSearch Result')
    PgSearch.stub_chain(:multisearch, :includes) { result }
    result.should_receive(:page).with(42)

    search_engine.search(SearchQuery.new('hi', 42))
  end
end
