require 'spec_helper'

feature "Viewing a user's cellar" do
  let(:bob) { Factory.create(:user) }

  background do
    christmas_ale = FactoryGirl.create(:brew, name: "Christmas Ale" )
    FactoryGirl.create_list(:beer, 3, brew: christmas_ale, user: bob)
    visit user_cellar_path(bob)
  end

  scenario "stocked with three Christmas Ales" do
    page.should have_content "Christmas Ale [3]"
  end

end
