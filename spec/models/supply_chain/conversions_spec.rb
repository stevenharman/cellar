require 'models/supply_chain/conversions'

describe SupplyChain::Conversions do
  subject(:conversions) { Object.new.extend(described_class) }

  describe '.boolean' do
    it 'is nil when nothing' do
      expect(conversions.boolean(nil)).to be_nil
    end

    it 'is falsey for "N"' do
      expect(conversions.boolean('N')).to be_falsey
    end

    it 'is truthy for "Y"' do
      expect(conversions.boolean('Y')).to be_truthy
    end
  end

  describe '.decimal' do
    it 'is nil when nothing' do
      expect(conversions.decimal(nil)).to be_nil
    end

    it 'is a decimal when given a number-looking string' do
      expect(conversions.decimal('1.234')).to eq(1.234)
    end
  end

  describe '.images' do
    it 'is empty when given nothing' do
      images = conversions.images(nil)
      expect(images.icon).to be_nil
      expect(images.medium).to be_nil
      expect(images.large).to be_nil
    end

    it 'is what it was given' do
      expect(conversions.images('picture!')).to eq('picture!')
    end
  end

  describe '.year' do
    it 'is nil when nothing' do
      expect(conversions.year(nil)).to be_nil
    end

    it 'is nil when they year-looking string is zero' do
      expect(conversions.year('0')).to be_nil
    end

    it 'is the Year when given a year-looking string' do
      expect(conversions.year('1999')).to eq(Date.new(1999))
    end
  end
end
