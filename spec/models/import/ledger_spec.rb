require 'spec_helper'

describe Import::Ledger do
  include ActionDispatch::TestProcess

  describe 'ensuring csv_file is correctly formatted' do
    subject(:ledger) { described_class.new(user: user, csv_file: csv_file) }
    let(:user) { User.new }

    context 'well-formed csv file' do
      let(:csv_file) { fixture_file_upload('founders-breakfast-stout.csv') }

      it 'is valid if all headers are found' do
        expect(ledger).to be_valid
      end
    end

    context 'csv file missing headers' do
      let(:csv_file) { fixture_file_upload('missing-brew-header.csv') }

      it 'reports missing headers' do
        expect(ledger).not_to be_valid
        expect(ledger.error_on(:csv_file).size).to eq(1)
        expect(ledger.errors_on(:csv_file)).to include('missing headers: Brew')
      end
    end

    context 'csv file incorrectly encoded' do
      let(:csv_file) { fixture_file_upload('invalid-encoding.csv') }

      it 'reports incorrect formatting' do
        expect(ledger).not_to be_valid
        expect(ledger.error_on(:csv_file).size).to eq(1)
        expect(ledger.errors_on(:csv_file)).to include('invalid encoding: File must be UTF-8 encoded.')
      end
    end
  end

  describe 'updating related match order status' do
    subject(:ledger) { FactoryGirl.create(:import_ledger) }

    it 'stores the job id with the ledger' do
      ledger.update_match_order_status('new')
      expect(ledger.match_order_status).to eq('new')
    end
  end
end
