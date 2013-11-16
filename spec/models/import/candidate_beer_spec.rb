require 'csv'
require 'spec_helper'

describe Import::CandidateBeer do
  describe 'building a candidate from a brew match and source row' do
    subject(:candidate) { described_class.build(match: brew_match, row: source_row) }
    let(:brew_match) { Search::BrewMatch.new([matched_brew]) }
    let(:matched_brew) { ::Brew.new }
    let(:source_row) { { brewery: 'Founders', brew: 'Breakfast Sout', best_by: '2016-10-15',
                         count: '2', notes: 'Booozy', size: '12oz', vintage: '2011'} }

    specify { expect(candidate.brew).to eq(matched_brew) }
    specify { expect(candidate.confidence).to eq(:high) }
    specify { expect(candidate.best_by).to eq(Date.new(2016, 10, 15)) }
    specify { expect(candidate.count).to eq(2) }
    specify { expect(candidate.notes).to eq('Booozy') }
    specify { pending('Lookup sizes'); expect(candidate.size).to eq(Size.new) }
    specify { expect(candidate.vintage).to eq(2011) }

    it 'keeps the original row' do
      expect(candidate.source_row).to eq(source_row)
    end

    context 'a CSV row' do
      subject(:candidate) { described_class.build(match: brew_match, row: csv_row) }
      let(:csv_row) { CSV::Row.new(source_row.keys, source_row.values) }

      it 'keeps the csv row as a hash' do
        expect(candidate.source_row).to eq(source_row)
      end
    end
  end
end
