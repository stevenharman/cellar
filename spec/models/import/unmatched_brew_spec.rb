require 'models/import/unmatched_brew'

describe Import::UnmatchedBrew do
  subject(:unmatched_brew) { described_class.new(source_attrs) }
  let(:source_attrs) { { brew: 'Red Rye' } }

  it 'uses the source brew as its name' do
    expect(unmatched_brew.name).to eq(source_attrs[:brew])
  end
end
