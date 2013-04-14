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

end
