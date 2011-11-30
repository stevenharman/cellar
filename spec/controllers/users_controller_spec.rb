require 'spec_helper'

describe UsersController do
  include Sorcery::TestHelpers::Rails

  describe 'GET /:username' do
    let(:bob) { Factory.create(:bob) }
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

  describe 'POST /users' do
    let(:bob_stuff) { Factory.attributes_for(:bob) }
    before { post :create, user: bob_stuff }

    it 'signs the new user in' do
      @controller.should be_logged_in
    end

    it { response.should redirect_to(root_path) }
  end

end
