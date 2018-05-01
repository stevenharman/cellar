require 'spec_helper'

describe 'Searching for a brew' do
  let!(:brew) { FactoryBot.create(:brew, name: 'Brooklyn Monster Ale')}
  let(:pagination) { json[:meta][:pagination] }

  it 'lists matching brews' do
    get brews_search_path, q: 'monster ale', format: :json
    expect(response).to be_success
    expect(json[:results].size).to eq(1)
  end

  it 'includes pagination meta data' do
    get brews_search_path, q: 'monster ale', format: :json
    expect(pagination[:page]).to eq(1)
    expect(pagination[:totalPages]).to eq(1)
    expect(pagination[:totalCount]).to eq(1)
  end
end
