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

  it 'forces search terms to UTF-8' do
    binary_terms = "Fantôme Saison D'Erezée - Printemps".force_encoding('ASCII-8BIT')
    query = described_class.new(terms: binary_terms)
    expect(query.terms.encoding).to eq(Encoding::UTF_8)
  end

  it 'it replaces invalid bytes in search terms' do
    binary_terms = "Fantôme\255".force_encoding('ASCII-8BIT')
    query = described_class.new(terms: binary_terms)
    expect(query.terms).to eq('Fantôme')
    expect{ query.terms =~ // }.not_to raise_error
  end
end
