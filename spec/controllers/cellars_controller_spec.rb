require 'spec_helper'

describe CellarsController do

  describe 'GET /:username' do

    context "When the users exists" do
      let(:bob) { double("User") }
      before { bob }

      it "load his cellar" do
        User.should_receive(:for_username!).and_return(bob)
        get :show, :username => 'bob'
        assigns(:cellar).keeper.should == bob
      end
    end

    context "When the user does not exist" do
      it "404's" do
        get :show, :username => 'girl-whos-not-there'
        response.should be_missing
      end
    end
  end

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

      # ~/bob/brew/bobs_brew -> 200
      specify "he can see his brew" do
        get :brew, user_id: bob, id: bobs_brew
        response.should be_success
      end

      # ~/bob/brew/alices_brew -> 200
      specify "he can see brews that are not currently in his cellar" do
        get :brew, user_id: bob, id: alices_brew
        response.should be_success
      end

      # ~/alice/brew/bobs_brew -> 404
      specify "he cannot see brew in Alice's Cellar" do
        get :brew, user_id: alice, id: bobs_brew
        response.should be_missing
      end

      # ~/alice/brew/alices_brew -> 404
      specify "he cannot see Alice's brew" do
        get :brew, user_id: alice, id: alices_brew
        response.should be_missing
      end

    end

    context 'and Bob is not signed in' do
      specify 'he cannot see his brew' do
        get :brew, user_id: bob, id: bobs_brew
        response.should redirect_to new_user_session_path
      end
    end
  end

end
