require 'models/supply_chain'
require 'models/supply_chain/brew_translation'

describe SupplyChain::BrewTranslation do
  subject(:translation) { described_class.new(brew, warehouse_map) }
  let(:brew) { OpenStruct.new(breweries: [], save: true) }
  let(:raw_data) { OpenStruct.new(id: 'li0U6A') }
  let(:warehouse_map) { double('WarehouseMap').as_null_object }

  context 'brew with a base' do
    let(:base_brew) { OpenStruct.new(id: base_id) }
    let(:base_id) { 'cqsB6i' }
    before do
      raw_data.beer_variation_id = base_id
    end

    it 'loads the base beer' do
      allow(warehouse_map).to receive(:find_brew).with(base_id) { base_brew }

      translated_brew = translation.call(raw_data)
      expect(translated_brew.base_brew).to be
    end

    it 'fails when the base beer is missing' do
      allow(warehouse_map).to receive(:find_brew).with(base_id) { nil }

      expect { translation.call(raw_data) }.
        to raise_error(SupplyChain::BrewMissingError, base_id)
    end
  end
end
