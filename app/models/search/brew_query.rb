require_relative 'query'

module Search
  class BrewQuery < Query

    def initialize(*)
      super
      @options = {trigram: false}.freeze
    end

    def document_scope
      'Brew'
    end

    def document_scoped?
      true
    end

  end
end
