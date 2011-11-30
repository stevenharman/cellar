require 'spec_helper'

describe UsersController do

  describe 'GET /:username' do
    let(:bob) { Factory.create(:user, username: 'bob') }
    before { bob }

    it "find the user if he exists" do
      User.should_receive(:for_username!).and_return(bob)
      get :show, :username => 'bob'
    end

    it "404's if the user does not exist" do
      expect { get :show, :username => 'girl-whos-not-there' }
        .to raise_error(ActiveRecord::RecordNotFound)
    end
  end

end
