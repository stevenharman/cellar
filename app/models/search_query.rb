require 'active_model'

class SearchQuery
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_reader :terms
  alias_method :q, :terms

  def initialize(terms = nil)
    @terms = terms
  end

  def persisted?; false; end

end
