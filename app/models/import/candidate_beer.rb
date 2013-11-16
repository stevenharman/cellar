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
  end
end
