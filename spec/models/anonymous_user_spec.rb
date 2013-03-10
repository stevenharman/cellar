require 'active_record_spec_helper'
require 'models/anonymous_user'
require 'models/beer'

describe AnonymousUser do
  subject(:user) { AnonymousUser.new }

  it { expect(user).not_to be_active }

  it { expect(user.cellared_beers).to be_empty }
end
