require 'support/active_model_lint'
require 'models/distribution_order'

describe DistributionOrder do

  describe 'ActiveModel Lint' do
    it_behaves_like 'ActiveModel'
  end

  describe '#reissue' do
    subject(:order) { described_class.new(beer_id: beer.id, status: 'drunk') }
    let(:beer) { double('Beer', id: 42, brew: brew) }
    let(:brew) { double('Brew', name: 'Darth Earnhardt') }
    let(:reissued_order) { order.reissue(beer) }

    it 'knows the beer id' do
      expect(reissued_order.beer_id).to eq(beer.id)
    end

    it 'knows the distribution status' do
      expect(reissued_order.status).to eq('drunk')
    end

    it 'knows the brew being distributed' do
      expect(reissued_order.brew).to eq(brew)
      expect(reissued_order.brew_name).to eq(brew.name)
    end
  end
end
