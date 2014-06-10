require 'spec_helper'

describe SearchesController do
  let(:search_results) { double('Search::Results') }

  it 'delegates to the search engine' do
    allow(Search::Engine).to receive(:search).with(instance_of Search::Query) { search_results }
    get :show, search: { query: 'meaning of life' }
    expect(assigns(:search_results)).to eq(search_results)
  end

end
