# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

puts "Creating users"

owner_user = User.create(
  email: "owner@xanyah.io",
  firstname: "Owner", lastname: "User",
  confirmed_at: Time.zone.now,
  password: "12345678",
  locale: "en"
)
admin_user = User.create(
  email:        "admin@xanyah.io",
  firstname:    "Admin",
  lastname:     "User",
  confirmed_at: Time.zone.now,
  password:     "12345678",
  locale:       "fr"
)
regular_user = User.create(
  email:        "regular@xanyah.io",
  firstname:    "Regular",
  lastname:     "User",
  confirmed_at: Time.zone.now,
  password:     "12345678",
  locale:       "en"
)

puts "Creating store"

store_name = Faker::StarWars.planet
demo_store = Store.create(name: store_name, country: "FR", key: store_name.to_slug)

puts "Creating store membership"

StoreMembership.create(store: demo_store, user: owner_user, role: :owner)
StoreMembership.create(store: demo_store, user: admin_user, role: :admin)
StoreMembership.create(store: demo_store, user: regular_user, role: :regular)

puts "Creating manufacturers, providers, categories"

5.times do
  Manufacturer.create(name: Faker::HarryPotter.character, store: demo_store)
  Provider.create(name: Faker::RickAndMorty.character, store: demo_store)
  Category.create(
    name:     Faker::Space.planet,
    store:    demo_store,
    tva:      %w[standard_rate reduced_rate reduced_rate_alt super_reduced_rate parking_rate].sample,
    category: [
      Category.create(
        name:  Faker::Space.planet,
        store: demo_store,
        tva:   %w[standard_rate reduced_rate reduced_rate_alt super_reduced_rate parking_rate].sample
      ),
      nil
    ].sample
  )
end
