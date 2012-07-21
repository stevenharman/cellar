require 'spec_helper'

describe Brewery do

  it 'validates uniqueness of name' do
    FactoryGirl.create(:brewery)
    Brewery.new.should validate_uniqueness_of(:name)
  end

  it { should validate_presence_of(:name) }
  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:website) }
  it { should have_many(:brews) }

end
