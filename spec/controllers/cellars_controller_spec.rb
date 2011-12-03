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

end
