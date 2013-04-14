require 'constraint/admin'

describe Constraint::Admin do
  subject(:constraint) { described_class.new }
  let(:a_request) { double('Request', env: { 'warden' => warden }) }
  let(:warden) { double('Warden') }

  it 'denies an unauthenticated user' do
    warden.stub(:authenticated?) { false }
    expect(constraint.matches?(a_request)).to be_false
  end

  context 'when authenticated' do
    let(:user) { double('User') }
    before do
      warden.stub(:authenticated?) { true }
      warden.stub(:user) { user }
    end

    it 'denies a non-admin user' do
      user.stub(:admin?) { false }
      expect(constraint.matches?(a_request)).to be_false
    end

    it 'allows an admin user' do
      user.stub(:admin?) { true }
      expect(constraint.matches?(a_request)).to be_true
    end
  end
end
