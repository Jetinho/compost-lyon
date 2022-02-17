class SiteDecorator < ApplicationDecorator
  delegate_all

  def self.collection_decorator_class
    MapMarkersDecorator
  end

  def composting_site_path
    condominium_site? ? condominium_site_path(site) : site_path(site)
  end

  def edit_composting_site_path
    condominium_site? ? edit_condominium_site_path(site) : edit_site_path(site)
  end

  def map_marker_display
    content = content_tag(:h6, content_tag(:b, name))
    content += label_and_content(label: 'Adresse', content: raw(format_address))
    content += label_and_content(label: 'Acteur', content: format_organisation)
    content += operation_conditions_label_and_content
    content += participation_conditions_label_and_content
    content += label_and_content(label: 'Contact', content: format_email) if contact_email
    content += details_btn
    content
  end

  def description
    preffix = "Composteur collectif #{format_site_type.downcase}"
    content = "\'#{formatted_name}\'."
    suffix = "Rejoignez-nous ou créez votre collectif pour composter à Lyon !"
    [preffix, content, suffix].join(' ')
  end

  private

  def operation_conditions_label_and_content
    return "" unless operation_conditions?

    label_and_content(label: 'Fonctionnement', content: simple_format(operation_conditions))
  end

  def participation_conditions_label_and_content
    return "" unless participation_conditions?

    label_and_content(label: 'Participation', content: simple_format(participation_conditions))
  end

  def format_address
    content = address ? address + tag(:br) : ""
    "#{content}#{zipcode} #{city}"
  end

  def details_btn
    link_to("+ d'infos", composting_site_path, target: :blank, class: 'btn btn-primary')
  end

  def format_organisation
    link_to(organisation.name, organisation_path(organisation), target: :blank)
  end

  def format_email
    mail_to(contact_email, contact_email)
  end

  def label_and_content(label:, content:)
    content_tag(:p, content_tag(:b, label)) + content_tag(:p, content)
  end
end
