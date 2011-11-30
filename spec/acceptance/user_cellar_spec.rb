require 'spec_helper'

feature "Viewing a user's cellar" do
  let(:bob) { Factory.create(:user) }

  background do
    christmas_ale = FactoryGirl.create(:brew, name: "Christmas Ale" )
    FactoryGirl.create_list(:beer, 3, brew: christmas_ale, user: bob)
  end

  scenario "show a summary of each brew in the cellar" do
    visit user_cellar_path(bob)
    page.should have_content "Christmas Ale [3]"
  end
end

feature "Control access to a Cellar" do

  # Bob owns beer 40, Alice owns beer 99
  # Signed in as Bob:
  # ~/bob/beer/40 -> 200
  scenario "Bob can view beer in his cellar"

  # ~/alice/beer/40 -> 404
  scenario "Bob cannot view his beer via Alice's cellar"

  # ~/alice/beer/99 -> 404
  scenario "Bob cannot view beer in Alice's cellar"

  # ~/bob/beer/99 -> 404
  scenario "Bob cannot view Alices's beer via his cellar"
end
