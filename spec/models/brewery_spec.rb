require 'spec_helper'

describe Brewery do

  describe 'images' do
    it 'does has no images when the logo does not exist' do
      brew = described_class.new
      expect(brew.icon?).to be_false
      expect(brew.medium_image?).to be_false
      expect(brew.large_image?).to be_false
    end

    it 'does has images when the logo does not exist' do
      brew = described_class.new(images: { icon: 'foo', medium_image: 'bar', large_image: 'zaa' })
      expect(brew.icon?).to be_true
      expect(brew.medium_image?).to be_true
      expect(brew.large_image?).to be_true
    end
  end
end
