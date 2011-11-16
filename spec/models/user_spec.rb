require 'spec_helper'

describe User do
  it { should validate_presence_of(:username) }
  it { should allow_mass_assignment_of(:username) }
  it 'validates uniqueness of username' do
    Factory(:user)
    User.new.should validate_uniqueness_of(:username)
  end

  it { should validate_presence_of(:email) }
  it { should allow_mass_assignment_of(:email) }

  describe "creating a user" do
    let(:bob) { Factory(:user) }

    it { bob.should be_valid }
  end
end
