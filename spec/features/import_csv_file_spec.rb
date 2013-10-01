require 'spec_helper'

feature 'Importing a CSV file', :file_upload_helpers do

  let!(:bob) { sign_in_new_user }

  scenario 'with all columns and a single beer' do
    visit new_import_path
    upload_file('founders-breakfast-stout.csv')
    expect_file_to_have_been_uploaded
    start_import
  end

  private

  def expect_file_to_have_been_uploaded
    expect(page).to have_text(I18n.t('flash.imports.create.success'))
  end

  def start_import
    pending('Driving out import')
    find('.start-import').click
  end

  def upload_file(name)
    attach_file('import_ledger_csv_file', File.join(fixture_path, name))
    find('input.upload-file').click
  end

end
