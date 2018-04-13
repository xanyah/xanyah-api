Rake::Task['vat_rates:update'].invoke

puts "Creating users"

owner_user = User.create!(
  email: "owner@xanyah.io",
  firstname: "Owner", lastname: "User",
  confirmed_at: Time.zone.now,
  password: "12345678",
  locale: "en",
  tokens: nil
)
admin_user = User.create!(
  email:        "admin@xanyah.io",
  firstname:    "Admin",
  lastname:     "User",
  confirmed_at: Time.zone.now,
  password:     "12345678",
  locale:       "fr",
  tokens: nil
)
regular_user = User.create!(
  email:        "regular@xanyah.io",
  firstname:    "Regular",
  lastname:     "User",
  confirmed_at: Time.zone.now,
  password:     "12345678",
  locale:       "en",
  tokens: nil
)

puts "Creating store"

store_name = Faker::StarWars.planet
demo_store = Store.create!(name: store_name, country: "FR", key: store_name.to_slug)

puts "Creating store membership"

StoreMembership.create!(store: demo_store, user: owner_user, role: :owner)
StoreMembership.create!(store: demo_store, user: admin_user, role: :admin)
StoreMembership.create!(store: demo_store, user: regular_user, role: :regular)

puts "Creating clients, manufacturers, providers, categories"

5.times do
  Client.create!(
    firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.phone_number,
    address: Faker::Address.street_address,
    notes: Faker::Lorem.paragraph,
    store:    demo_store
  )
  Manufacturer.create!(name: Faker::HarryPotter.character, store: demo_store)
  Provider.create!(name: Faker::RickAndMorty.character, store: demo_store)
  Category.create!(
    name:     Faker::Space.planet,
    store:    demo_store,
    tva:      Category.tvas.keys.sample,
    category: [
      Category.create!(
        name:  Faker::Space.planet,
        store: demo_store,
        tva:   Category.tvas.keys.sample
      ),
      nil
    ].sample
  )
end

100.times do |idx|
  price = rand(5...100)
  Variant.create!(
    product: Product.create!(
      name: "#{Faker::Food.dish} ##{idx}",
      store: demo_store,
      manufacturer: Manufacturer.all.sample,
      category: Category.all.sample,
      ),
      provider: Provider.all.sample,
    original_barcode: idx.to_s.rjust(10, "0"),
    buying_price: price,
    tax_free_price: price * 1.5,
    ratio: 1.5,
    quantity: rand(0...20),
  )
end
