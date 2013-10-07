module ControllerTestHelpers

  def sign_in(user)
    if user.is_a?(User) && user.persisted?
      @request.env['devise.mapping'] = Devise.mappings[:user]
      #user.confirm! unless user.confirmed?
      super(user)
    else # likely a stub user, so stub Devise too.
      allow(controller).to receive(:authenticate_user!) { user }
      allow(controller).to receive(:current_user) { user }
      allow(user).to receive(:username) { 'bob' } unless user.respond_to?(:username) && user.username
    end
  end

end
