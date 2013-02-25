require_relative 'application_decorator'
require_relative '../models/brew'

class BrewDecorator < ApplicationDecorator
  decorates :brew
  delegate_all

  def style_name
    style && style.name
  end
end
