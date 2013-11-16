require 'batch'

module Import
  class Agent
    attr_reader :match_order, :matches

    def self.match(match_order)
      new(match_order).match
    end

    def initialize(match_order, matches: Search::Match)
      @match_order = match_order
      @matches = matches
    end

    def match
      Batch.run do |batch|
        spreadsheet_rows.each do |row|
          match = matches.find_brew(extract_terms(row))
          batch.cancel unless match_order.add_to_ledger(match: match, row: row)
        end

        match_order.done
      end
    end

    private

    def spreadsheet_rows
      match_order.spreadsheet
    end

    def extract_terms(row)
      "#{row[:brewery]} #{row[:brew]}".strip
    end

  end
end
