module SettingsHelper

  def active_nav(item)
    'is-active' if controller_name.singularize == item
  end

end
