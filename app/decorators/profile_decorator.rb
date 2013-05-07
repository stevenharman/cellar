class ProfileDecorator < ApplicationDecorator
  delegate_all
  decorates_association :cellar
  decorates_association :user

  delegate :gravatar, to: :user

  def website_name
    strip_protocol(website)
  end

end
