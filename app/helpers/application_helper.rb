module ApplicationHelper
  def site_text(key)
    current_settings.text(key)
  end
end
