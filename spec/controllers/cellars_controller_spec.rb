require 'spec_helper'

describe CellarsController do
  include Sorcery::TestHelpers::Rails

  describe 'GET /:username' do

    context "When the users exists" do
      let(:bob) { Factory.create(:bob) }
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
    let(:bobs_brew) { FactoryGirl.create(:brew) }
    before { FactoryGirl.create(:beer, user: bob, brew: bobs_brew) }

    context "and Bob signed in" do
      before { login_user bob }

      # ~/bob/brew/bobs_brew -> 200
      specify "he can see his brew"

      # ~/alice/brew/bobs_brew -> 404
      specify "he cannot see his brew via Alice's Cellar"

      # ~/alice/brew/alices_brew -> 404
      specify "he cannot see Alice's brew"

      # ~/bob/brew/alices_brew -> 404
      specify "he cannot see Alice's brew view his cellar"
    end

    context 'and Bob is not signed in' do
      specify 'he cannot see his brew' do
        get :brew, user_id: bob, id: bobs_brew
        response.should redirect_to sign_in_path
      end
    end
  end

end
