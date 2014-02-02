require 'spec_helper'

describe Search::ResultsDecorator do

  it 'decorates breweries' do
    decorator = described_class.new([Brewery.new])
    decorator.first.should be_a(Search::BreweryDecorator)
  end

  it 'decorates brews' do
    decorator = described_class.new([Brew.new])
    decorator.first.should be_a(Search::BrewDecorator)
  end

  describe 'unknown result' do
    it 'fails meaningfully trying to decorat' do
      decorator = described_class.new([double])
      expect { decorator.first }.to raise_error NoMethodError
    end
  end
end
