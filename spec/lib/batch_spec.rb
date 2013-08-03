require 'active_record_spec_helper'
require 'batch'

describe Batch do
  subject(:batch) { described_class.new }

  it 'yields itself to the block' do
    batch.run do |b|
      expect(b).to eq(batch)
    end
  end

  it 'runs the block within a transaction' do
    turn_off_rspec_transactions

    batch.run do |b|
      expect(ActiveRecord::Base.connection.transaction_open?).to be_true
    end
  end

  it 'rolls back when cancelled' do
    expect{ batch.cancel }.to raise_error(ActiveRecord::Rollback)
  end

  def turn_off_rspec_transactions
    expect(ActiveRecord::Base.connection.transaction_open?).to be_true
    DatabaseCleaner.clean
    expect(ActiveRecord::Base.connection.transaction_open?).to be_false
  end
end
