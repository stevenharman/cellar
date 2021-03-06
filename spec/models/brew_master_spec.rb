require 'models/brew_master'

describe BrewMaster do

  describe 'Processing a beer order' do
    let(:order) { StockOrder.new(brew: brew, count: 3) }
    let(:brew) { double('Brew', name: 'Boont Amber Ale', id: 99) }
    before do
      stub_const('Beer', double)
      allow(Beer).to receive(:make).with(order.to_hash, brew) { double('Beer') }
    end

    it 'makes the specified number of beers' do
      beers = described_class.process(order)
      expect(beers.size).to eq(3)
    end
  end

end
