require 'support/active_model_lint'
require 'models/search_query'

describe SearchQuery do
  describe 'ActiveModel Lint' do
    it_behaves_like "ActiveModel"
  end

  it 'defaults to the first page' do
    expect(described_class.new.page).to eq(1)
  end
end
