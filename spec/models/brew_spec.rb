require 'spec_helper'

describe Brew do

  it { should belong_to(:brewery) }

  it 'validates uniqueness of name' do
    Factory.create(:brew)
    Brewery.new.should validate_uniqueness_of(:name)
  end

  it { should validate_presence_of(:name) }
  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:abv) }
end
