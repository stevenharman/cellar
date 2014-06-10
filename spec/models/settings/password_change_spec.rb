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
        allow(user).to receive(:valid_password?).with(current_password) { true }
        allow(user).to receive(:update_password) { true }
      end

      it 'updates the user password' do
        expect(user).to receive(:update_password).with(new_password)
        password_change.call(change_params)
      end

      it 'reports the change was successful' do
        expect(password_change.call(change_params)).to be true
      end
    end

    context 'current password is invalid' do
      before do
        allow(user).to receive(:valid_password?) { false }
      end

      it 'does not update the user password' do
        expect(user).not_to receive(:update_password)
        password_change.call(change_params)
      end

      it 'reports the change was not successful' do
        expect(password_change.call(change_params)).to be_falsey
      end
    end
  end

  describe 'ActiveModel Lint' do
    it_behaves_like 'ActiveModel'
  end

end
