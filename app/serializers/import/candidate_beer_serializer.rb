module Import
  class CandidateBeerSerializer < ApplicationSerializer
    attributes :id, :confidence, :best_by, :count, :notes, :vintage,
      :source, :isMatched

    has_one :brew
    has_one :size

    def isMatched
      object.matched?
    end

    def source
      {
        brew: object.source_brew,
        brewery: object.source_brewery,
        size: object.source_size
      }
    end

  end
end
