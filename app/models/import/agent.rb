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
          match = matches.find_brew(row)
          batch.cancel unless match_order.add_to_ledger(match)
        end

        match_order.done
      end
    end

    private

    def spreadsheet_rows
      match_order.spreadsheet
    end

  end
end
