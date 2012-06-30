module ControllerHelpers

  def sign_in(user)
    if user.is_a?(User) && user.persisted?
      @request.env["devise.mapping"] = Devise.mappings[:user]
      #user.confirm! unless user.confirmed?
      super(user)
    else # likely a stub user, so stub Devise too.
      controller.stub(:authenticate_user!) { user }
      controller.stub(:current_user) { user }
      user.stub(:username) { 'bob' } unless user.username
    end
  end

end
