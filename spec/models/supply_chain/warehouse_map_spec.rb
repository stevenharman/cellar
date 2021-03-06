require 'models/supply_chain/warehouse_map'

describe SupplyChain::WarehouseMap do
  subject(:map) { described_class.new }

  it 'finds an Availability by brewery_db_id' do
    stub_const('Availability', double)
    an_availability = double('a Availability')
    allow(Availability).to receive(:find_by_brewery_db_id).with('bdb_id') { an_availability }

    expect(map.find_availability('bdb_id')).to eq(an_availability)
  end

  it 'finds a Category by brewery_db_id' do
    stub_const('Category', double)
    a_category = double('a Category')
    allow(Category).to receive(:find_by_brewery_db_id).with('bdb_id') { a_category }

    expect(map.find_category('bdb_id')).to eq(a_category)
  end

  it 'finds a Style by brewery_db_id' do
    stub_const('Style', double)
    a_style = double('a Style')
    allow(Style).to receive(:find_by_brewery_db_id).with('bdb_id') { a_style }

    expect(map.find_style('bdb_id')).to eq(a_style)
  end

  it 'finds Brewery instances by a list of brewery_db_ids' do
    stub_const('Brewery', double)
    brewery_1, brewery_2 = [double('Brewery 1'), double('Brewery 2')]
    allow(Brewery).to receive(:find_by_brewery_db_ids).with(['bdb_id_1', 'bdb_id_2']) { [brewery_1, brewery_2]}

    breweries = map.find_breweries(['bdb_id_1', 'bdb_id_2'])
    expect(breweries).to eq([brewery_1, brewery_2])
  end

  it 'finds a Brew by brewery_db_id' do
    stub_const('Brew', double)
    a_brew = double('a Brew')
    allow(Brew).to receive(:find_by_brewery_db_id).with('bdb_id') { a_brew }

    expect(map.find_brew('bdb_id')).to eq(a_brew)
  end

end
