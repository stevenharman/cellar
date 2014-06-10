require 'models/supply_chain/job'

describe SupplyChain::Job do
  subject(:job_module) { described_class }

  describe 'including into a job' do
    let(:fake_directory) { [] }
    before do
      allow(job_module).to receive(:directory) { fake_directory }
    end

    it 'registers the job with the directory' do
      FakeJob.send(:include, SupplyChain::Job)

      expect(job_module.directory).to eq([FakeJob])
    end

    class FakeJob; end
  end

end
