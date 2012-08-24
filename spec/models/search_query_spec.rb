require 'support/active_model_lint'
require 'models/search_query'

describe SearchQuery do
  describe 'ActiveModel Lint' do
    it_behaves_like "ActiveModel"
  end
end
