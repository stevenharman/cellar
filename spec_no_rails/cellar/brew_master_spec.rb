require 'fast_spec_helper'
app_require 'app/cellar/brew_master'

describe BrewMaster do

  describe 'Processing a beer order' do
    let(:order) { double("BeerOrder") }
    let(:brew) { double("Brew") }
    before do
      order.stub(brew_id: 123)
      order.stub(beers: [])
      Brew.stub(:find_by_id).and_return(brew)
    end

    it 'finds the specified brew' do
      Brew.should_receive(:find_by_id).with(123)
      BrewMaster.process(order)
    end

    describe 'with beer params' do
      let(:beer_stuff) { double("Beer Params") }
      before { order.stub(beers: [beer_stuff]) }

      it 'makes a beer for the brew' do
        Beer.should_receive(:make).with(beer_stuff, brew)
        BrewMaster.process(order)
      end
    end
  end

  protected

  class Brew; end unless defined?(Brew)
  class Beer; end unless defined?(Beer)

end
