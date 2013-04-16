require 'active_model'

module Settings
  class PasswordChange
    extend ActiveModel::Naming
    include ActiveModel::Conversion
    include ActiveModel::Validations

    attr_reader :current, :new, :user

    validates :current, presence: true
    validate :current_password_match?
    # NOTE: Sadly, this must be kept in check with the User#password validations
    validates :new, presence: true, length: { in: 8...128 }

    def initialize(user)
      @user = user
    end

    def call(passwords)
      extract(passwords)

      user.update_password(new) if self.valid?
    end

    def persisted?; false; end

    private

    def current_password_match?
      unless user.valid_password?(current)
        errors.add(:current)
      end
    end

    def extract(passwords)
      @current = passwords[:current]
      @new = passwords[:new]
    end

  end
end
