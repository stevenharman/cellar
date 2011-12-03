require 'spec_helper'

describe UsersController do
  include Sorcery::TestHelpers::Rails

  describe 'POST /users' do
    let(:bob_stuff) { Factory.attributes_for(:bob) }
    before { post :create, user: bob_stuff }

    it 'signs the new user in' do
      @controller.should be_logged_in
    end

    it { response.should redirect_to(root_path) }
  end

end
