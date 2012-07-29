require 'vcr_spec_helper'
require 'models/warehouse'

describe Warehouse do
  subject { described_class.new }

  describe '#breweries' do
    it 'fetches categories from BreweryDB', vcr: { record: :once } do
      categories = subject.categories
      expect(categories.first.id).to be_kind_of Fixnum
      expect(categories.each).to be_kind_of Enumerator
      expect(categories.count).to eq(12)
    end

    it 'fetches breweries from BreweryDB', vcr: { record: :once } do
      breweries = subject.breweries
      expect(breweries.first.id).to be_kind_of String
      expect(breweries.each).to be_kind_of Enumerator
      #TODO: use #size as soon as it's implemented.
      expect(breweries.count).to eq(3316)
    end
  end

end
