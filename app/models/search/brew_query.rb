module Search
  class BrewQuery

    attr_reader :terms

    def initialize(terms: nil)
      @terms = terms
    end

    def blank?
      terms.nil? || terms == ''
    end

    def document_scope
      'Brew'
    end

    def document_scoped?
      true
    end

    def paged?
      false
    end
  end
end
