# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

exit 0 if ENV['PREVENT_SEEDING']

puts "Creating users"

owner_user = User.create(email: 'owner@xanyah.io', firstname: 'Owner', lastname: 'User', confirmed_at: Time.now, password: '12345678')
admin_user = User.create(email: 'admin@xanyah.io', firstname: 'Admin', lastname: 'User', confirmed_at: Time.now, password: '12345678')
regular_user = User.create(email: 'regular@xanyah.io', firstname: 'Regular', lastname: 'User', confirmed_at: Time.now, password: '12345678')

puts "Creating store"

store_name = Faker::StarWars.planet
demo_store = Store.create(name: store_name, country: 'FR', key: store_name.to_slug)

puts "Creating store membership"

StoreMembership.create(store: demo_store, user: owner_user, role: :owner)
StoreMembership.create(store: demo_store, user: admin_user, role: :admin)
StoreMembership.create(store: demo_store, user: regular_user, role: :regular)

puts "Creating manufacturers, providers"
5.times do
  Manufacturer.create(name: Faker::HarryPotter.character, store: demo_store)
  Provider.create(name: Faker::RickAndMorty.character, store: demo_store)
end
