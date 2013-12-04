require 'active_model/errors'
require 'email_validator'

describe EmailValidator do
  let(:validator) { described_class.new(attributes: :email) }
  let(:record) { double('Model', errors: ActiveModel::Errors.new(nil) ) }

  it 'allows valid-but-crazy emails (farmed from Wikipedia)' do
    validator.validate_each(record, 'email', 'user@[IPv6:2001:db8:1ff::a0b:dbd0]')
  end
end
