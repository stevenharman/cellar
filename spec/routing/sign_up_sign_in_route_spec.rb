require 'spec_helper'

describe "Sign up and Sign out routes" do

  it { get("/sign_up").should route_to("users#new")}
  it { get("/sign_in").should route_to("sessions#new")}

end
