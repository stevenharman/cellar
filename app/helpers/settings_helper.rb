module SettingsHelper

  def activate_setting(item)
    'active' if controller_name.singularize == item
  end

end
