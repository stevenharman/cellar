require 'support/active_model_lint'
require 'models/distribution_order'

describe DistributionOrder do

  describe 'ActiveModel Lint' do
    it_behaves_like 'ActiveModel'
  end

  describe '.prepare' do
    let(:order) { described_class.prepare(args, beer_factory) }
    let(:args) { { beer_id: 456, status: 'drunk'} }
    let(:beer_factory) { double('Beer') }
    let(:beer) { double('a Beer') }
    before do
      beer_factory.stub(:find_by_id).with(456) { beer }
    end

    it 'finds the beer for the order' do
      expect(order.beer).to eq(beer)
    end

    it 'maps the status' do
      expect(order.status).to eq('drunk')
    end
  end

  describe 'an order' do
    subject(:order) { described_class.new(beer: beer) }
    let(:beer) { double('Beer', brew: brew) }
    let(:brew) { double('Brew', name: 'Darth Earnhardt') }

    it 'knows the brew being distributed' do
      expect(order.brew).to eq(brew)
      expect(order.brew_name).to eq(brew.name)
    end
  end
end
