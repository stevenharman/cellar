require 'models/clerk'

describe Clerk do
  subject(:clerk) { described_class.new(cellar, brew_master) }
  let(:cellar) { double('Cellar', add: true) }
  let(:brew_master) { double('BrewMaster') }
  let(:order) { double('order') }
  let(:beer) { double('Beer') }
  let(:a_batch) { double('Batch') }

  describe '#procure' do
    before do
      Batch.stub(:run).and_yield(a_batch)
      brew_master.stub(:process).with(order) { [beer, beer] }
    end

    it 'adds the beer to the cellar' do
      cellar.should_receive(:add).with(beer).twice
      a_batch.should_not_receive(:cancel)
      clerk.procure(order)
    end

    it 'cancels the batch if any beer fails to be added' do
      cellar.stub(:add).and_return(true, false)
      a_batch.should_receive(:cancel)
      clerk.procure(order)
    end
  end
end
