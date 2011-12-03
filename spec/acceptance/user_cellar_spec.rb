require 'spec_helper'

feature "Viewing a user's cellar" do
  let(:bob) { Factory.create(:user) }

  background do
    christmas_ale = FactoryGirl.create(:brew, name: "Christmas Ale" )
    FactoryGirl.create_list(:beer, 3, brew: christmas_ale, user: bob)
  end

  scenario "show a summary of each brew in the cellar" do
    visit user_cellar_path(bob)
    page.should have_text "Christmas Ale [3]"
  end
end
