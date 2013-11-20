module Search
  class BrewQuery

    attr_reader :terms, :options

    def initialize(terms: '')
      terms = String(terms).force_encoding('utf-8')
      terms = terms.chars.select {|c| c.valid_encoding?}.join unless terms.valid_encoding?
      @terms = terms
      @options = { trigram: false }.freeze
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
