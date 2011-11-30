require 'spec_helper'

describe UsersController do

  describe 'GET /:username' do
    before { Factory.create(:user, username: 'bob') }

    it "find the user if he exists" do
      get :show, :username => 'bob'
      assigns(:cellar).user.username.should == 'bob'
    end

    it "is case insensitive" do
      get :show, :username => "BoB"
      assigns(:cellar).user.username.should == 'bob'
    end

    it "404's if the user does not exist" do
      expect { get :show, :username => 'girl-whos-not-there' }
        .to raise_error(ActiveRecord::RecordNotFound)
    end
  end

end
