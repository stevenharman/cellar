require 'spec_helper'

describe SearchesController do
  let(:search_result) { stub('SearchResult') }

  it 'delegates to the search engine' do
    SearchEngine.stub(:search).with(instance_of SearchQuery) { search_result }
    get :show, search: { query: 'meaning of life' }
    expect(assigns(:search_result)).to eq(search_result)
  end

end
