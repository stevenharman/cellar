require 'spec_helper'

describe Brew do

  describe '#calculate_cellared_beers_count' do
    subject(:brew) { FactoryGirl.create(:brew) }
    before do
      FactoryGirl.create(:beer, :cellared, brew: brew)
      FactoryGirl.create(:beer, :traded, brew: brew)
    end

    it 'updates the count of cellared beers for this brew' do
      brew.calculate_cellared_beers_count
      expect(brew.cellared_beers_count).to eq(1)
    end
  end

  describe 'labels' do
    it 'does has no images when the label does not exist' do
      brew = described_class.new
      expect(brew.icon?).to be false
      expect(brew.medium_image?).to be false
      expect(brew.large_image?).to be false
    end

    it 'does has images when the label does not exist' do
      brew = described_class.new(labels: { icon: 'foo', medium_image: 'bar', large_image: 'zaa' })
      expect(brew.icon?).to be true
      expect(brew.medium_image?).to be true
      expect(brew.large_image?).to be true
    end
  end

end
