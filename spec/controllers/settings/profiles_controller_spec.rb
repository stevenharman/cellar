require 'spec_helper'

describe Settings::ProfilesController do

  describe 'A user updating their' do
    let(:bob) { FactoryGirl.create(:bob) }
    before { sign_in bob }

    it 'is successful when the update is allowed' do
      put :update, {profile: {website: 'http://me.co', bio: 'Just me.'}}
      expect(response).to redirect_to(settings_profile_path)
      expect(assigns(:profile).website).to eq('http://me.co')
    end
  end
end
