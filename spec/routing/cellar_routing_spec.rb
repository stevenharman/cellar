require 'spec_helper'

describe 'Routes for Cellars' do

  it { get("/bob/brews").should_not be_routable  }

  it "shows an brew from a user's cellar" do
    get("/bob/brews/42").should route_to({
      user_id: 'bob',
      controller: 'cellared_brews',
      action: 'show',
      id: '42'
    })
  end

end
