require 'spec_helper'

describe UsersController do

  describe 'POST /users' do
    let(:bob_stuff) { { username: 'bob', email: 'bob@example.com', password: 'password' } }
    let(:user) { assigns(:user) }
    before { post :create, user: bob_stuff }

    it 'creates the user, but he is not confirmed' do
      expect(@controller).not_to be_user_signed_in
      expect(user).not_to be_confirmed
    end

    it { response.should redirect_to(root_path) }
  end

end
