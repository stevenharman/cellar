require 'models/clean_up'

describe CleanUp do
  subject(:clean_up) { described_class }

  describe '.brewery' do
    let(:brewery) { stub('Brewery', id: 42, brewery_db_id: 'abc123') }

    it 'destroys the brewery if we have no beers for it' do
      BeersFromBreweryQuery.stub(:new).with(brewery) { [] }
      brewery.should_receive(:destroy)

      clean_up.brewery(brewery)
    end

    it 'fails to destroy the brewery when it has beers' do
      BeersFromBreweryQuery.stub(:new).with(brewery) { [stub('Beer')] }
      expect { clean_up.brewery(brewery) }.to raise_error(/cannot be destroyed; it has 1 beers cellared/)
    end
  end

  describe '.brew' do
    let(:brew) { stub('Brew', id: 42, brewery_db_id: 'abc123') }

    it 'destroys the brew if we had no beers for it' do
      brew.stub(:beers) { [] }
      brew.should_receive(:destroy)

      clean_up.brew(brew)
    end

    it 'fails to destroy the brew when it has beers' do
      brew.stub(:beers) { [stub('Beer')] }

      expect { clean_up.brew(brew) }.to raise_error(/cannot be destroyed; it has 1 beers cellared/)
    end
  end
end
