require 'spec_helper'

feature 'Importing a CSV file', :file_upload_helpers do

  let!(:bob) { sign_in_new_user }

  scenario 'with all columns and a single beer' do
    visit new_import_path
    upload_file('founders-breakfast-stout.csv')
    expect_file_to_have_been_uploaded
    continue_import
    expect_matching_to_be_underway
    refresh_the_page
    expect_to_see_match_report
  end

  private

  def expect_file_to_have_been_uploaded
    expect(page).to have_text(I18n.t('flash.imports.create.success'))
  end

  def expect_matching_to_be_underway
    expect(page).to have_text(I18n.t('flash.import.match_orders.show.notice'))
  end

  def expect_to_see_match_report
    expect(page).to have_text(I18n.t('flash.import.match_orders.show.success'))
  end

  def continue_import
    find('.continue-import').click
  end

  def refresh_the_page
    Import::MatchJob.drain
    find('a.refresh').click
  end

  def upload_file(name)
    attach_file('import_ledger_csv_file', File.join(fixture_path, name))
    find('input.upload-file').click
  end

end
