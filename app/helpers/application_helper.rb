module ApplicationHelper

  # Translations in config/locales/fr.yml
  def action_path_name(action)
    I18n.t("resources.#{action}")
  end

  # Translations in config/locales/pages_data/content.yml
  def page_path_name(page)
    I18n.t("pages.#{page}.path_name")
  end
  alias :resource_path_name :page_path_name

  def menu_item_name(page)
    I18n.t("pages.#{page}.menu_item_name")
  end

  def page_name(page)
    I18n.t("pages.#{page}.name")
  end

  def page_meta_title(page)
    I18n.t("pages.#{page}.meta_title", default: page_title(page))
  end

  def page_title(page)
    I18n.t("pages.#{page}.title")
  end

  def page_meta_description(page)
    I18n.t("pages.#{page}.meta_description", default: page_description(page))
  end

  def page_description(page)
    raw I18n.t("pages.#{page}.description")
  end

  def devise_path_name(action)
    I18n.t("devise.path_names.#{action}")
  end

  def successful_update_flash_message
    I18n.t("flashes.successful_update")
  end
end
