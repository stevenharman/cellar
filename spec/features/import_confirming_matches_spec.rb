require 'spec_helper'

feature 'Import: Confirming matched beers' do
  let!(:match) { FactoryGirl.create(:import_candidate_beer, :medium_confidence, ledger: ledger) }
  let(:ledger) { FactoryGirl.create(:import_ledger, user: bob) }
  let(:bob) { sign_in_new_user }

  scenario 'confirm a potential match', :js, :slow do
    visit import_match_report_path
    matches = ledger.candidate_beers
    expect_confidence(match, :medium)
    confirm(match)
    expect_confirmed(match)
  end

  private

  def expect_confidence(match, confidence)
    expect(page).to have_css(".match-#{match.id}.#{confidence.to_s}")
  end

  def expect_confirmed(match)
    expect_confidence(match, :confirmed)
  end

  def confirm(match)
    find_match(match, ".confirm-match").click
  end

  def find_match(match, selectors = '')
    find([".match-#{match.id}", selectors].join(' '))
  end

end
