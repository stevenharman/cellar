require 'support/active_model_lint'
require 'models/settings/password_change'

describe Settings::PasswordChange do
  subject(:password_change) { described_class.new(user) }
  let(:user) { double('User', valid_password?: true) }
  let(:change_params) { { new: new_password, current: current_password } }
  let(:new_password) { 'new password' }
  let(:current_password) { 'current password' }

  describe '#call' do

    context 'current password is valid' do
      before do
        user.stub(:valid_password?).with(current_password) { true }
        user.stub(:update_password) { true }
      end

      it 'updates the user password' do
        user.should_receive(:update_password).with(new_password)
        password_change.call(change_params)
      end

      it 'reports the change was successful' do
        expect(password_change.call(change_params)).to be_true
      end
    end

    context 'current password is invalid' do
      before do
        user.stub(:valid_password?) { false }
      end

      it 'does not update the user password' do
        user.should_not_receive(:update_password)
        password_change.call(change_params)
      end

      it 'reports the change was not successful' do
        expect(password_change.call(change_params)).to be_false
      end
    end
  end

  describe 'ActiveModel Lint' do
    it_behaves_like 'ActiveModel'
  end

end
