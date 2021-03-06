require 'spec_helper'

describe CellarsController do

  describe 'GET /:username' do
    context 'When the user exists' do
      let(:bob) { User.new }
      before { bob }

      it 'load his cellar' do
        expect(User).to receive(:for_username!).and_return(bob)
        get :show, :username => 'bob'
        expect(assigns(:cellar).keeper).to eq(bob)
      end
    end

    context 'When the user does not exist' do
      it "404's" do
        get :show, :username => 'girl-whos-not-there'
        expect(response).to be_missing
      end
    end
  end
end
