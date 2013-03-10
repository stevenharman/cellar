require 'models/cellared_beer_statistics'

describe CellaredBeerStatistics do

  describe '.analyze' do
    let(:keeper) { double('User') }
    let(:raw_stats) { Hash.new }

    it 'loads the cellared beer stats for the keeper' do
      CellaredBeerStatisticsQuery.stub(:query).with(keeper) { raw_stats }
      stats = described_class.analyze(keeper)
      expect(stats.to_hash).to eq(raw_stats)
    end
  end

  describe 'tallying stats' do
    subject(:stats) { described_class.new(raw_stats) }
    let(:raw_stats) { { brew_1.id => 1, brew_2.id => 3 } }
    let(:brew_1) { OpenStruct.new(id: 1) }
    let(:brew_2) { OpenStruct.new(id: 2) }

    describe '#beers_count' do
      it 'tallies all beers when no brew is specified' do
        expect(stats.beers_count).to eq(4)
      end

      it 'counts only the specified brew' do
        expect(stats.beers_count(brew_1)).to eq(1)
        expect(stats.beers_count(brew_2)).to eq(3)
      end

      it 'reports zero when there is no stat for the brew' do
        other_brew = OpenStruct.new(id: 42)
        expect(stats.beers_count(other_brew)).to eq(0)
      end
    end

    describe '#brews_count' do
      it 'is zero when there are no stats' do
        stats = described_class.new({})
        expect(stats.brews_count).to eq(0)
      end

      it 'counts the brews we have stats on' do
        expect(stats.brews_count).to eq(2)
      end
    end
  end
end
