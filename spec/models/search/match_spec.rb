require 'models/search/match'

describe Search::Match do
  describe 'finding a matching brew' do
    subject(:match) { described_class.new(engine: engine) }
    let(:engine) { double('Search::Engine') }
    let(:results) { [:result_1] }

    before do
      allow(engine).to receive(:search) { results }
    end

    it 'uses the search engine to find matches' do
      expect(engine).to receive(:search).with(an_instance_of(Search::BrewQuery))
      the_match = match.find_brew('brewdega')
      expect(the_match.candidate).to eq(:result_1)
    end
  end

end
