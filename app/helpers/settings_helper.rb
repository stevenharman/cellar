module SettingsHelper

  def activate_setting(item)
    'is-active' if controller_name.singularize == item
  end

end
