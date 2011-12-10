require 'spec_helper'

describe 'Routes for Cellars' do

  it { get("/bob/brews").should_not be_routable  }

  it "shows an brew from a user's cellar" do
    get("/bob/brew/42").should route_to({
      user_id: 'bob',
      controller: 'cellars',
      action: 'brew',
      id: '42'
    })
  end

  it "can drink a beer from a user's cellar" do
    put("/bob/beer/99/drink"). should route_to({
      user_id: 'bob',
      controller: 'beers',
      action: 'drink',
      id: '99'
    })
  end

end

