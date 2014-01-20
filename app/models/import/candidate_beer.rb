require 'active_support/core_ext/hash/indifferent_access'
require_relative '../import'

module Import
  class CandidateBeer < ActiveRecord::Base
    belongs_to :ledger, inverse_of: :candidate_beers, foreign_key: :import_ledger_id
    belongs_to :brew
    belongs_to :size

    CONFIDENCES = %w(unknown none medium high confirmed).freeze

    validates :ledger, presence: true
    validates :confidence, inclusion: CONFIDENCES
    validates :vintage, numericality: { allow_nil: true, only_integer: true }

    store_accessor :source_row

    IMPORTABLE_ATTRIBUTES.each do |key|
      define_method("source_#{key}") do
        source_row[key.to_s]
      end
    end

    CONFIDENCES.each do |c|
      define_method("#{c}?") do
        self.confidence.to_s == c
      end
    end

    def self.build(match: match, row: row)
      row = row.to_hash if row.respond_to?(:to_hash)
      row = row.to_h.with_indifferent_access

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

    def brew
      super || UnmatchedBrew.new(source_row)
    end

    def confidence=(value)
      write_attribute(:confidence, value.to_s)
    end

    def confirm
      update(confidence: :confirmed)
    end

    def matched?
      confirmed? || high? || medium?
    end
  end
end
