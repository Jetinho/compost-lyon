class SiteDecorator < ApplicationDecorator
  delegate_all
  include Rails.application.routes.url_helpers

  def self.collection_decorator_class
    MapMarkersDecorator
  end

  def map_marker_display
    content = content_tag(:h6, content_tag(:b, name))
    content += label_and_content(label: 'Adresse', content: raw(format_address))
    content += label_and_content(label: 'Acteur', content: format_organisation)
    content += label_and_content(label: 'Fonctionnement', content: operation_conditions) if operation_conditions?
    content += label_and_content(label: 'Participation', content: participation_conditions) if participation_conditions?
    content += label_and_content(label: 'Contact', content: format_email) if contact_email
    content += details_btn
    content
  end

  private

  def format_address
    content = address ? address + tag(:br) : ""
    content + zipcode + ' ' + city
  end

  def details_btn
    link_to("+ d'infos", site_path(site), target: :blank, class: 'btn btn-primary')
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


    # // text +=  "<p><b>Organisme :</b></p>"
    # // text +=  "<p>" + "<a href=" + site.organisation_website + ">"+ site.organisation_name + "</a>\r\n"
    # // text +=  "<p>" + site.organisation_name + "</p>"

end
