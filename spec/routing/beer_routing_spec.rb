require 'spec_helper'

describe 'Routes for Beer' do

  it { get("/beers").should route_to("beers#index") }
  it { get("/beers/new").should route_to("beers#new") }
  it { post("/beers").should route_to("beers#create") }
  it { get("/beers/42").should_not be_routable  }

  it "shows an individual beer from in a user's cellar" do
    get("/bob/beers/42").should route_to({
      user_id: 'bob',
      controller: 'beers',
      action: 'show',
      id: '42'
    })
  end

  it "edits an individual beer from in a user's cellar" do
    get("/bob/beers/42/edit").should route_to({
      user_id: 'bob',
      controller: 'beers',
      action: 'edit',
      id: '42'
    })
  end

  it "updates an individual beer from in a user's cellar" do
    put("/bob/beers/42").should route_to({
      user_id: 'bob',
      controller: 'beers',
      action: 'update',
      id: '42'
    })
  end
end
