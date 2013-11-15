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
end
