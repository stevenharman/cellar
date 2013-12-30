require 'csv'
require 'spec_helper'

describe Import::CandidateBeer do
  describe 'a new candidate' do
    subject(:candidate) { described_class.new }

    it 'has unknown confidence' do
      expect(candidate.confidence).to eq('unknown')
    end

    it 'is not confirmed' do
      expect(candidate.confirmed?).not_to be(true)
    end
  end

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
    specify { pending('NOT IMPLEMENTED: Lookup sizes'); expect(candidate.size).to eq(Size.new) }
    specify { expect(candidate.vintage).to eq(2011) }

    it 'keeps the original row' do
      expect(candidate.source_row).to eq(source_row.with_indifferent_access)
    end

    context 'with a CSV row' do
      subject(:candidate) { described_class.build(match: brew_match, row: csv_row) }
      let(:csv_row) { CSV::Row.new(source_row.keys, source_row.values) }

      it 'keeps the csv row as a hash' do
        expect(candidate.source_row).to eq(source_row.with_indifferent_access)
      end
    end

    context 'no mathing Brew was found' do
      subject(:candidate) { described_class.build(match: brew_match, row: source_row) }
      let(:brew_match) { Search::BrewMatch.new([]) }

      it 'uses an UnmatchedBrew for the brew' do
        expect(candidate.brew).to be_a(Import::UnmatchedBrew)
      end

      it 'passes the source row on to the unmatched brew' do
        expect(candidate.brew.brewery).to eq(source_row[:brewery])
      end
    end

    describe 'checking for a match' do
      it 'is matched when confidence is high' do
        candidate.confidence = :high
        expect(candidate).to be_matched
      end

      it 'is matched when confidence is medium' do
        candidate.confidence = :medium
        expect(candidate).to be_matched
      end

      it 'is not matched when confidence none' do
        candidate.confidence = :none
        expect(candidate).not_to be_matched
      end

      it 'is not matched when confidence unknown' do
        candidate.confidence = :unknown
        expect(candidate).not_to be_matched
      end
    end
  end
end
