require 'models/clerk'

describe Clerk do
  let(:clerk) { described_class.new(cellar, brew_master) }
  let(:cellar) { double('Cellar', name: 'bob', add: true) }
  let(:brew_master) { double('BrewMaster') }
  let(:order) { double('order') }
  let(:beer) { double('Beer') }

  describe '#procure' do
    before do
      cellar.stub(:transaction).and_yield
      brew_master.stub(:process).with(order) { [beer, beer] }
    end

    it 'adds the beer to the cellar' do
      cellar.should_receive(:add).with(beer).twice
      clerk.procure(order)
    end

    it 'cancels the batch if one beer fails to be added' do
      cellar.stub(:add).and_return(true, false)
      expect { clerk.procure(order) }.to raise_error(ActiveRecord::Rollback)
    end
  end
end
