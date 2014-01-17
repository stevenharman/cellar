module Import
  class CandidateBeerSerializer < ApplicationSerializer
    attributes :id, :confidence, :bestBy, :count, :notes, :vintage,
      :source, :isMatched

    has_one :brew
    has_one :size

    def bestBy
      object.best_by
    end

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
