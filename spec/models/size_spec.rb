require 'active_record_spec_helper'
require 'models/size'

describe Size do

  context 'case' do
    it 'does not require a quantity' do
      size = Size.new(brewery_db_id: 42, measure: 'case')
      expect(size.valid?).to be_true
    end
  end

end
