require 'spec_helper'

describe Import::Ledger do
  include ActionDispatch::TestProcess

  describe 'ensuring spreadsheet is correctly formatted' do
    subject(:ledger) { described_class.new(user: user, spreadsheet: spreadsheet) }
    let(:user) { User.new }

    context 'well-formed csv file' do
      let(:spreadsheet) { fixture_file_upload('spec/support/file_fixtures/founders-breakfast-stout.csv') }

      it 'is valid if all headers are found' do
        expect(ledger).to be_valid
      end
    end

    context 'csv file missing headers' do
      let(:spreadsheet) { fixture_file_upload('spec/support/file_fixtures/missing-brew-header.csv') }

      it 'reports missing headers' do
        expect(ledger).not_to be_valid
        expect(ledger).to have(1).error_on(:spreadsheet)
        expect(ledger.errors_on(:spreadsheet)).to include('missing headers: Brew')
      end
    end
  end
end
