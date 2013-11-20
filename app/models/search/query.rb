require 'active_model'

module Search
  class Query
    extend ActiveModel::Naming
    include ActiveModel::Conversion
    include ActiveModel::Validations

    attr_reader :terms, :options, :page
    alias_method :q, :terms

    DEFAULT_PAGE = 1

    def initialize(terms: nil, page: DEFAULT_PAGE)
      @terms = terms
      @page = (page || DEFAULT_PAGE)
      @options = {trigram: true}.freeze
    end

    def blank?
      terms.nil? || terms == ''
    end

    def document_scoped?
      false
    end

    def paged?
      !!page
    end

    def persisted?; false; end

  end
end
