require 'vcr_spec_helper'
require 'models/warehouse'

describe Warehouse do
  subject { described_class.new }

  describe '#breweries', vcr: { record: :once, cassette_name: 'brewery_db-breweries'} do
    it 'fetches breweries from BreweryDB' do
      breweries = subject.breweries
      expect(breweries.first.id).to be_kind_of String
      expect(breweries.each).to be_kind_of Enumerator
      #TODO: use #size as soon as it's implemented.
      expect(breweries.count).to eq(3312)
    end
  end

end
