require 'vcr_spec_helper'
require 'models/import/warehouse'

describe Import::Warehouse do
  subject { described_class.new }

  it 'fetches categories from BreweryDB', vcr: { record: :once } do
    categories = subject.categories
    expect(categories.first.id).to be_kind_of Fixnum
    expect(categories.each).to be_kind_of Enumerator
    expect(categories.count).to eq(12)
  end

  it 'fetches styles from BreweryDB', vcr: { record: :once } do
    styles = subject.styles
    expect(styles.first.id).to be_kind_of Fixnum
    expect(styles.first.category_id).to be_kind_of Fixnum
    expect(styles.each).to be_kind_of Enumerator
    expect(styles.count).to eq(157)
  end

  it 'fetches breweries from BreweryDB', vcr: { record: :once } do
    breweries = subject.breweries
    expect(breweries.first.id).to be_kind_of String
    expect(breweries.each).to be_kind_of Enumerator
    #TODO: use #size as soon as it's implemented.
    expect(breweries.count).to eq(3316)
  end

  it "fetches a brewery's beers", vcr: { record: :once } do
    brews = subject.brews_for_brewery('Idm5Y5')
    expect(brews.first.id).to be_kind_of String
    expect(brews.each).to be_kind_of Enumerator
    expect(brews.count).to eq(22)
  end

end