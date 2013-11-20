require 'support/active_model_lint'
require 'models/search/query'

describe Search::Query do
  subject(:query) { described_class.new }

  describe 'ActiveModel Lint' do
    it_behaves_like 'ActiveModel'
  end

  it 'defaults to the first page' do
    expect(query.page).to eq(1)
    expect(query).to be_paged
  end

  it 'is always paged' do
    expect(described_class.new(page: false)).to be_paged
    expect(described_class.new(page: nil)).to be_paged
  end

  it 'uses trigrams' do
    expect(query.options).to eq(trigram: true)
  end

  it 'is not scoped to a type of document' do
    expect(query).not_to be_document_scoped
  end
end
