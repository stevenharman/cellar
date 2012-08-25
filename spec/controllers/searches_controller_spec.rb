require 'spec_helper'

describe SearchesController do
  let(:search_result) { stub('Search::Result') }

  it 'delegates to the search engine' do
    Search::Engine.stub(:search).with(instance_of Search::Query) { search_result }
    get :show, search: { query: 'meaning of life' }
    expect(assigns(:search_result)).to eq(search_result)
  end

end
