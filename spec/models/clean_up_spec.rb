require 'models/clean_up'

describe CleanUp do
  subject(:clean_up) { described_class }

  describe '.brewery' do
    let(:brewery_db_id) { 'abc123' }
    let(:brewery) { stub('Brewery', id: 42, brewery_db_id: brewery_db_id) }
    let(:brewery_factory) { stub('Brewery class') }
    before do
      brewery_factory.stub(:find_by_brewery_db_id).with(brewery_db_id) { brewery }
    end

    it 'destroys the brewery if we have no beers for it' do
      BeersFromBreweryQuery.stub(:new).with(brewery) { [] }
      brewery.should_receive(:destroy)

      clean_up.brewery(brewery_db_id, brewery_factory)
    end

    it 'fails to destroy the brewery when it has beers' do
      BeersFromBreweryQuery.stub(:new).with(brewery) { [stub('Beer')] }
      expect { clean_up.brewery(brewery_db_id, brewery_factory) }.to raise_error(/cannot be destroyed; it has 1 beers cellared/)
    end
  end
end
