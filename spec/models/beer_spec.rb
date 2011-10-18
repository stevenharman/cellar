require 'spec_helper'

describe Beer do
  it { should belong_to(:brew) }

  it { should validate_presence_of(:brew) }
  it { should validate_presence_of(:inventory) }
  it { should validate_numericality_of(:inventory) }
  it { should_not allow_value(-1).for(:inventory) }
  it { should_not allow_value(1.5).for(:inventory) }

  it { should allow_mass_assignment_of(:inventory) }
  it { should allow_mass_assignment_of(:batch) }
  it { should allow_mass_assignment_of(:born_on) }
  it { should allow_mass_assignment_of(:best_by) }
  it { should allow_mass_assignment_of(:description) }
end
