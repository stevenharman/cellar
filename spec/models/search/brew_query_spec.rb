require 'models/search/brew_query'

describe Search::BrewQuery do
  subject(:query) { described_class.new }

  it 'is not paged' do
    expect(query).not_to be_paged
  end

  it 'is scoped to Brew documents' do
    expect(query).to be_document_scoped
    expect(query.document_scope).to eq('Brew')
  end
end
