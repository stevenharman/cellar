module Features
  module PasswordHelpers

    def expect_user_can_sign_in_with_new_password(user, password)
      user.password = password
      sign_out(user)
      sign_in(user)

      expect(page).to have_content I18n.t('flash.sessions.create.notice', name: user.username)
      expect(current_path).to eq(root_path)
    end
  end
end
