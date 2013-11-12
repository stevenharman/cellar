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
        expect(ledger).to have(1).error_on(:csv_file)
        expect(ledger.errors_on(:csv_file)).to include('missing headers: Brew')
      end
    end
  end

  describe 'attaching a match job' do
    subject(:ledger) { FactoryGirl.create(:import_ledger) }

    it 'stores the job id with the ledger' do
      jid = ledger.attach_job('abc123')
      expect(jid).to eq('abc123')
      expect(ledger.match_job_id).to eq(jid)
    end
  end
end
