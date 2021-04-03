class SiteNameFormatter
  def self.format(name)
    format_name = name.gsub(/(?:le|les)\s?compost?(\w)+/i, 'Composteur')
    format_name.prepend('Composteur ') unless format_name.split.first == 'Composteur'
    format_name.strip
  end

  def self.format_slug(name, formatted_name = false)
    return name.parameterize if formatted_name
    format(name).parameterize
  end
end
