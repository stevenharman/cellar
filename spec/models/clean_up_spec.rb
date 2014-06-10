require 'models/clean_up'

describe CleanUp, :type => :model do
  subject(:clean_up) { described_class }

  describe '.brewery' do
    let(:brewery) { double('Brewery', id: 42, brewery_db_id: 'abc123') }

    it 'destroys the brewery if we have no beers for it' do
      allow(BeersFromBreweryQuery).to receive(:query).with(brewery) { [] }
      expect(brewery).to receive(:destroy)

      clean_up.brewery(brewery)
    end

    it 'fails to destroy the brewery when it has beers' do
      allow(BeersFromBreweryQuery).to receive(:query).with(brewery) { [double('Beer')] }
      expect { clean_up.brewery(brewery) }.to raise_error(/cannot be destroyed; it has 1 beers cellared/)
    end
  end

  describe '.brew' do
    let(:brew) { double('Brew', id: 42, brewery_db_id: 'abc123') }

    it 'destroys the brew if we had no beers for it' do
      allow(brew).to receive(:beers) { [] }
      expect(brew).to receive(:destroy)

      clean_up.brew(brew)
    end

    it 'fails to destroy the brew when it has beers' do
      allow(brew).to receive(:beers) { [double('Beer')] }

      expect { clean_up.brew(brew) }.to raise_error(/cannot be destroyed; it has 1 beers cellared/)
    end
  end
end
