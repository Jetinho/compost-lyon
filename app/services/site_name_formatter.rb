class SiteNameFormatter
  def self.format(name)
    format_name = if name.start_with?(/(le\s|les\s)?compost?(\w)+\b/i)
      name.gsub(/(?:le|les)?\s?compost?(\w)+/i, 'Composteur')
    else
      name.prepend('Composteur ')
    end
    format_name.strip
  end

  def self.format_slug(name, formatted_name = false)
    return name.parameterize if formatted_name
    format(name).parameterize
  end
end
