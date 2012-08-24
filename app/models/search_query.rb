require 'active_model'

class SearchQuery
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_reader :terms, :page
  alias_method :q, :terms

  def initialize(terms = nil, page = 1)
    @terms = terms
    @page = page
  end

  def persisted?; false; end

end
