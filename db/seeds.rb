# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ORGANISATIONS = ["Eisenia", "Grand Lyon Métropole"]
ORGANISATIONS.each do |name|
  Organisation.create(name: name, slug: name.parameterize)
end

importer = SitesImporter.new
Organisation.all.each do |o|
  importer.import o.slug
end
