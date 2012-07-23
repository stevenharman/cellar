require 'spec_helper'

describe Brewery do

  it { should validate_presence_of(:name) }
  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:website) }
  it { should have_many(:brews) }

end
