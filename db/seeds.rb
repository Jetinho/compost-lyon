# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Cleaning database"
Site.destroy_all
CollectiveComposting::Organisation.destroy_all
puts "Creating test user"

user = User.create(email: "test@mail.com", password: 'password')
puts "Creating organisations"

ORGANISATIONS = ["Eisenia", "Grand Lyon Métropole"]
 ORGANISATIONS.each do |name|
  CollectiveComposting::Organisation.create(name: name, slug: name.parameterize, user_id: user.id)
 end
 puts "#{CollectiveComposting::Organisation.count} organisations created"
sleep 4

puts "Updating organisations"

eisenia = CollectiveComposting::Organisation.find_by(slug: :eisenia)
eisenia.update(description: "Installation et maintenance de lombricomposteurs collectifs à Lyon métropole, sensibilisation et éducation à l'écologie")
grand_lyon_metropole = CollectiveComposting::Organisation.find_by(slug: "grand-lyon-metropole")
grand_lyon_metropole.update(
  description: "Pour développer la pratique du compostage et réduire la quantité de déchets dans les poubelles des habitants, la Métropole de Lyon accompagne le déploiement de composteurs partagés sur son territoire.",
  slug: "grand-lyon-metropole"
)

puts "Creating sites through importer"
importer = SitesImporter.new
imported_count = 0
CollectiveComposting::Organisation.all.each_with_index do |o, i|
  importer.import o.slug
  puts "#{Site.count - imported_count} sites imported from #{o.name} organisation"
  imported_count = Site.count - imported_count
end
puts "#{Site.count} sites created"
puts "Database ready!"
