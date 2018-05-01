require 'spec_helper'

describe InventoryReport do

  describe '.calculate' do
    subject(:report) { described_class }
    let(:brew) { FactoryBot.create(:brew) }

    it 'updates the cellared beer count' do
      expect(brew.reload.cellared_beers_count).to eq(0)

      FactoryBot.create_list(:beer, 2, brew: brew)
      report.calculate(brew)
      expect(brew.reload.cellared_beers_count).to eq(2)
    end
  end

end
