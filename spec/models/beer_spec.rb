require 'spec_helper'

describe Beer do
  it { should belong_to(:brew) }

  it { should validate_presence_of(:brew) }

  it { should allow_mass_assignment_of(:batch) }
  it { should allow_mass_assignment_of(:bottled_on) }
  it { should allow_mass_assignment_of(:best_by) }
end
