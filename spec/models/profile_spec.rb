require 'support/active_model_lint'
require 'models/profile'

describe Profile do
  subject(:profile) { described_class.new(cellar) }
  let(:cellar) { double('Cellar', keeper: keeper, beers_count: 5, brews_count: 3, total_breweries: 9) }
  let(:keeper) { double('User', gravatar: 'http://grav.co', username: 'bob', website: 'http://web.co') }

  it 'delegates user concerns to the keeper' do
    expect(profile.gravatar).to eq(keeper.gravatar)
    expect(profile.username).to eq(keeper.username)
    expect(profile.website).to eq(keeper.website)
  end

  it 'delegates cellar concerns to the cellar' do
    expect(profile.beers_count).to eq(cellar.beers_count)
    expect(profile.brews_count).to eq(cellar.brews_count)
    expect(profile.total_breweries).to eq(cellar.total_breweries)
  end

  describe '#update' do
    let(:profile_params) { {website: 'http://me.co', bio: 'new bio'} }

    it 'updates the user' do
      keeper.should_receive(:update_attributes).with(profile_params)
      profile.update(profile_params)
    end
  end

  describe 'ActiveModel Lint' do
    it_behaves_like 'ActiveModel'
  end
end
