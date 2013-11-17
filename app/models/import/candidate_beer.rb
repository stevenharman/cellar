module Import
  class CandidateBeer < ActiveRecord::Base
    belongs_to :ledger, inverse_of: :candidate_beers, foreign_key: :import_ledger_id
    belongs_to :brew
    belongs_to :size

    validates :ledger, presence: true
    validates :confidence, inclusion: [:none, :medium, :high]
    validates :vintage, numericality: { allow_nil: true, only_integer: true }

    SOURCE_KEYS = %i(brewery brew best_by count notes size vintage).freeze
    store_accessor :source_row

    SOURCE_KEYS.each do |key|
      define_method("source_#{key}") do
        source_row[key.to_s]
      end
    end

    def self.build(match: match, row: row)
      row = row.to_hash if row.respond_to?(:to_hash)
      row = row.to_h

      new(
        brew: match.candidate,
        confidence: match.confidence,
        best_by: row[:best_by],
        count: row[:count],
        notes: row[:notes],
        #size: row[:size],
        vintage: row[:vintage],
        source_row: row.to_hash
      )
    end
  end
end