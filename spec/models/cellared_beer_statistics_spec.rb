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
end
