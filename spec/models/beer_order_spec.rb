require 'support/active_model_lint'
require 'models/beer_order'

describe BeerOrder do
  subject(:order) { described_class.new(args)}
  let(:brew) { stub(name: 'Black Ops', id: 42) }
  let(:args) { { count: '3', batch: 'abc', brew: brew } }

  describe 'ActiveModel Lint' do
    it_behaves_like 'ActiveModel'
  end

  describe '#count' do
    it 'defaults to a count of 1' do
      expect(described_class.new.count).to eq(1)
    end

    it 'requires a miniumm of 1 beer to be ordered' do
      order = described_class.new(count: -1)
      expect(order).not_to be_valid
      expect(order.errors[:count]).to have(1).error
    end
  end

  it 'knows the brew name' do
    expect(order.brew_name).to eq(brew.name)
  end

  it 'knows the brew id' do
    expect(order.brew_id).to eq(brew.id)
  end
end
