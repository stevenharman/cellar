require 'models/anonymous_user'

describe AnonymousUser do
  subject(:user) { AnonymousUser.new }

  it { expect(user).not_to be_active }
end
