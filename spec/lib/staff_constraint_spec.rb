require 'constraint/staff'

describe Constraint::Staff do
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

    it 'denies a non-staff user' do
      user.stub(:staff?) { false }
      expect(constraint.matches?(a_request)).to be_false
    end

    it 'allows an staff user' do
      user.stub(:staff?) { true }
      expect(constraint.matches?(a_request)).to be_true
    end
  end
end
