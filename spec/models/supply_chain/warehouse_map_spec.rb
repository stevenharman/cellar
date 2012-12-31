require 'models/supply_chain/warehouse_map'

describe SupplyChain::WarehouseMap do
  subject(:map) { described_class }

  describe '.boolean' do
    it 'is nil when nothing' do
      expect(map.boolean(nil)).to be_nil
    end

    it 'is falsey for "N"' do
      expect(map.boolean('N')).to be_false
    end

    it 'is truthy for "Y"' do
      expect(map.boolean('Y')).to be_true
    end
  end

  describe '.decimal' do
    it 'is nil when nothing' do
      expect(map.decimal(nil)).to be_nil
    end

    it 'is a decimal when given a number-looking string' do
      expect(map.decimal('1.234')).to eq(1.234)
    end
  end

  describe '.images' do
    it 'is empty when given nothing' do
      images = map.images(nil)
      expect(images.icon).to be_nil
      expect(images.medium).to be_nil
      expect(images.large).to be_nil
    end

    it 'is what it was given' do
      expect(map.images('picture!')).to eq('picture!')
    end
  end

  describe '.year' do
    it 'is nil when nothing' do
      expect(map.year(nil)).to be_nil
    end

    it 'is nil when they year-looking string is zero' do
      expect(map.year('0')).to be_nil
    end

    it 'is the Year when given a year-looking string' do
      expect(map.year('1999')).to eq(Date.new(1999))
    end
  end
end
