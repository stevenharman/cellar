require 'spec_helper'

describe CellarBeersController do

  let(:bob) { FactoryGirl.create(:bob) }
  let(:alice) { FactoryGirl.create(:alice) }
  let(:bobs_beer) { FactoryGirl.create(:beer, user: bob) }
  let(:alices_beer) { FactoryGirl.create(:beer, user: alice) }

  context 'When Bob is signed in' do
    before { sign_in bob }

    # ~/bob/beers/bobs_beer -> 200
    it 'he can see his beer' do
      get :show, cellar_id: bob, id: bobs_beer
      response.should be_success
    end

    # ~/alice/beers/bobs_beer -> 404
    it "he cannot see his beer via Alice's cellar" do
      get :show, cellar_id: alice, id: bobs_beer
      response.should be_missing
    end

    # ~/alice/beers/alices_beer -> 404
    it "he cannot see Alice's beer" do
      get :show, cellar_id: alice, id: alices_beer
      response.should be_missing
    end

    # ~/bob/beers/alices_beer -> 404
    it "he cannot see Alice's beer via his cellar" do
      get :show, cellar_id: bob, id: alices_beer
      response.should be_missing
    end
  end

  context 'When Bob is not signed in' do
    it 'he cannot see his beer' do
      get :show, cellar_id: bob, id: bobs_beer
      response.should redirect_to new_user_session_path
    end
  end
end

