require 'models/search/brew_query'

describe Search::BrewQuery do
  subject(:query) { described_class.new }

  it 'is scoped to Brew documents' do
    expect(query).to be_document_scoped
    expect(query.document_scope).to eq('Brew')
  end

  it 'does not use trigrams' do
    expect(query.options).to eq(trigram: false)
  end

end
