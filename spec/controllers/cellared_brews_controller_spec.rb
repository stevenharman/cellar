require 'spec_helper'

describe CellaredBrewsController do

  describe "When viewing a Brew" do
    let(:bob) { FactoryGirl.create(:bob) }
    let(:alice) { FactoryGirl.create(:alice) }
    let(:bobs_brew) { FactoryGirl.create(:brew) }
    let(:alices_brew) { FactoryGirl.create(:brew) }
    before do
      FactoryGirl.create(:beer, user: bob, brew: bobs_brew)
      FactoryGirl.create(:beer, user: alice, brew: alices_brew)
    end

    context "and Bob signed in" do
      before { sign_in bob }

      # ~/bob/brews/bobs_brew -> 200
      specify "he can see his brew" do
        get :show, user_id: bob, id: bobs_brew
        response.should be_success
      end

      # ~/bob/brews/alices_brew -> 200
      specify "he can see brews that are not currently in his cellar" do
        get :show, user_id: bob, id: alices_brew
        response.should be_success
      end

      # ~/alice/brews/bobs_brew -> 404
      specify "he cannot see brew in Alice's Cellar" do
        get :show, user_id: alice, id: bobs_brew
        response.should be_missing
      end

      # ~/alice/brews/alices_brew -> 404
      specify "he cannot see Alice's brew" do
        get :show, user_id: alice, id: alices_brew
        response.should be_missing
      end

    end

    context 'and Bob is not signed in' do
      specify 'he cannot see his brew' do
        get :show, user_id: bob, id: bobs_brew
        response.should redirect_to new_user_session_path
      end
    end
  end

end
