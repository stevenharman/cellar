require 'support/active_model_lint'
require 'models/search/query'

describe Search::Query do
  subject(:query) { described_class.new }

  describe 'ActiveModel Lint' do
    it_behaves_like 'ActiveModel'
  end

  it 'defaults to the first page' do
    expect(query.page).to eq(1)
  end

  it 'uses trigrams' do
    expect(query.options).to eq(trigram: true)
  end

  it 'is not scoped to a type of document' do
    expect(query).not_to be_document_scoped
  end

  it 'normalizes nil search terms' do
    expect(described_class.new(terms: nil).terms).to eq('')
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
