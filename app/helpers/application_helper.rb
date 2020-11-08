module ApplicationHelper
  def action_path_name(action)
    I18n.t("resources.#{action}")
  end

  def resource_path_name(resource)
    I18n.t("resources.#{resource}.name").parameterize
  end

  def resource_name(resource)
    I18n.t("resources.#{resource}.name")
  end

  def resource_description(resource)
    I18n.t("resources.#{resource}.description")
  end

  def page_path_name(page)
    I18n.t("pages.#{page}").parameterize
  end

  def page_name(page)
    I18n.t("pages.#{page}")
  end
end
