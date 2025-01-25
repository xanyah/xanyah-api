# frozen_string_literal: true

Rake::Task['vat_rates:update'].invoke

Rails.logger.debug 'Creating users'

owner_user = User.create!(
  email: 'owner@xanyah.io',
  firstname: 'Owner',
  lastname: 'User',
  confirmed_at: Time.zone.now,
  password: '12345678',
  locale: 'en',
  tokens: nil
)
admin_user = User.create!(
  email: 'admin@xanyah.io',
  firstname: 'Admin',
  lastname: 'User',
  confirmed_at: Time.zone.now,
  password: '12345678',
  locale: 'fr',
  tokens: nil
)
regular_user = User.create!(
  email: 'regular@xanyah.io',
  firstname: 'Regular',
  lastname: 'User',
  confirmed_at: Time.zone.now,
  password: '12345678',
  locale: 'en',
  tokens: nil
)

Rails.logger.debug 'Creating store'

store_name = 'EasySport'
demo_store = Store.create!(
  name: store_name,
  country: 'FR',
  key: store_name.parameterize
)

Rails.logger.debug 'Creating store membership'

StoreMembership.create!(
  store: demo_store,
  user: owner_user,
  role: :owner
)

StoreMembership.create!(
  store: demo_store,
  user: admin_user,
  role: :admin
)

StoreMembership.create!(
  store: demo_store,
  user: regular_user,
  role: :regular
)

Rails.logger.debug 'Creating customers, manufacturers, providers, categories, payment types'

5.times do
  PaymentType.create!(
    name: Faker::Currency.name,
    description: Faker::Lorem.paragraph,
    store: demo_store
  )
  Customer.create!(
    firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.phone_number,
    address: Faker::Address.street_address,
    notes: Faker::Lorem.paragraph,
    store: demo_store
  )
  Manufacturer.create!(
    name: Faker::Movies::HarryPotter.character,
    notes: Faker::Lorem.paragraph,
    store: demo_store
  )
  Provider.create!(
    name: Faker::TvShows::RickAndMorty.character,
    notes: Faker::Lorem.paragraph,
    store: demo_store
  )
end

Rails.logger.debug 'Creating Categories'

# Sports

sports_parent_category = Category.create!(
  name: 'Sports',
  store: demo_store,
  tva: Category.tvas.keys.sample
)

basketball_category = Category.create!(
  name: 'Basketball',
  store: demo_store,
  tva: Category.tvas.keys.sample,
  category: sports_parent_category
)

football_category = Category.create!(
  name: 'Football',
  store: demo_store,
  tva: Category.tvas.keys.sample,
  category: sports_parent_category
)

rugby_category = Category.create!(
  name: 'Rugby',
  store: demo_store,
  tva: Category.tvas.keys.sample,
  category: sports_parent_category
)

# Clothing

clothing_parent_category = Category.create!(
  name: 'Clothing',
  store: demo_store,
  tva: Category.tvas.keys.sample
)

men_category = Category.create!(
  name: 'Men',
  store: demo_store,
  tva: Category.tvas.keys.sample,
  category: clothing_parent_category
)

women_category = Category.create!(
  name: 'Women',
  store: demo_store,
  tva: Category.tvas.keys.sample,
  category: clothing_parent_category
)

children_category = Category.create!(
  name: 'Children',
  store: demo_store,
  tva: Category.tvas.keys.sample,
  category: clothing_parent_category
)

Rails.logger.debug 'Creating Products'

# Sports

price1 = rand(5...100)
basket_ball_hoop_product = Product.create!(
  name: 'Basketball Hoop',
  store: demo_store,
  manufacturer: Manufacturer.all.sample,
  category: basketball_category,
  provider: Provider.all.sample,
  upc: '0000000001',
  buying_price: price1,
  tax_free_price: price1 * 1.5,
  ratio: 1.5,
  quantity: rand(0...20)
)

price2 = rand(5...100)
soccer_ball_product = Variant.create!(
  product: Product.create!(
    name: 'Soccer Ball',
    store: demo_store,
    manufacturer: Manufacturer.all.sample,
    category: football_category
  ),
  provider: Provider.all.sample,
  original_barcode: '0000000002',
  buying_price: price2,
  tax_free_price: price2 * 1.5,
  ratio: 2,
  quantity: rand(0...20)
)

price3 = rand(5...100)
rugby_ball_product = Variant.create!(
  product: Product.create!(
    name: 'Rugby Ball',
    store: demo_store,
    manufacturer: Manufacturer.all.sample,
    category: rugby_category
  ),
  provider: Provider.all.sample,
  original_barcode: '0000000003',
  buying_price: price3,
  tax_free_price: price3 * 1.5,
  ratio: 2,
  quantity: rand(0...20)
)

# Clothing

price4 = rand(5...100)
polo_men_product = Variant.create!(
  product: Product.create!(
    name: 'Polo',
    store: demo_store,
    manufacturer: Manufacturer.all.sample,
    category: men_category
  ),
  provider: Provider.all.sample,
  original_barcode: '0000000003',
  buying_price: price4,
  tax_free_price: price4 * 1.5,
  ratio: 2,
  quantity: rand(0...20)
)

price5 = rand(5...100)
sport_bra_women_product = Variant.create!(
  product: Product.create!(
    name: 'Sport Bra',
    store: demo_store,
    manufacturer: Manufacturer.all.sample,
    category: women_category
  ),
  provider: Provider.all.sample,
  original_barcode: '0000000003',
  buying_price: price5,
  tax_free_price: price5 * 1.5,
  ratio: 2,
  quantity: rand(0...20)
)

price6 = rand(5...100)
jogging_children_product = Variant.create!(
  product: Product.create!(
    name: 'Jogging',
    store: demo_store,
    manufacturer: Manufacturer.all.sample,
    category: children_category
  ),
  provider: Provider.all.sample,
  original_barcode: '0000000003',
  buying_price: price6,
  tax_free_price: price6 * 1.5,
  ratio: 2,
  quantity: rand(0...20)
)

Rails.logger.debug 'Creating Orders'

order1 = Order.create!(
  customer: Customer.all.sample,
  store: demo_store,
  status: 'pending',
  order_products: []
)

order2 = Order.create!(
  customer: Customer.all.sample,
  store: demo_store,
  status: 'delivered',
  order_products: []
)

order3 = Order.create!(
  customer: Customer.all.sample,
  store: demo_store,
  status: 'canceled',
  order_products: []
)

OrderVariant.create!(
  product: jogging_children_product,
  order: order1,
  quantity: rand(0...20)
)

OrderVariant.create!(
  product: soccer_ball_product,
  order: order1,
  quantity: rand(0...20)
)

OrderVariant.create!(
  product: polo_men_product,
  order: order2,
  quantity: rand(0...20)
)

OrderVariant.create!(
  product: basket_ball_hoop_product,
  order: order2,
  quantity: rand(0...20)
)

OrderVariant.create!(
  product: sport_bra_women_product,
  order: order3,
  quantity: rand(0...20)
)

OrderVariant.create!(
  product: rugby_ball_product,
  order: order3,
  quantity: rand(0...20)
)

OrderVariant.create!(
  product: jogging_children_product,
  order: order1,
  quantity: rand(0...20)
)

Rails.logger.debug 'Creating Inventories'

inventory1 = Inventory.create!(
  store: demo_store,
  inventory_products: []
)

inventory2 = Inventory.create!(
  store: demo_store,
  inventory_products: []
)

InventoryVariant.create!(
  inventory: inventory1,
  product: jogging_children_product,
  quantity: rand(0...20)
)

InventoryVariant.create!(
  inventory: inventory1,
  product: sport_bra_women_product,
  quantity: rand(0...20)
)

InventoryVariant.create!(
  inventory: inventory2,
  product: basket_ball_hoop_product,
  quantity: rand(0...20)
)

InventoryVariant.create!(
  inventory: inventory2,
  product: rugby_ball_product,
  quantity: rand(0...20)
)

inventory2.update(locked_at: Time.zone.now)

Rails.logger.debug 'Creating Sales'

sale1 = Sale.create!(
  total_price: 15,
  store: demo_store,
  customer: Customer.all.sample,
  user: regular_user
)

SalePayment.create!(
  sale: sale1,
  payment_type: PaymentType.all.sample
)

SaleVariant.create!(
  sale: sale1,
  product: rugby_ball_product,
  quantity: 1
)

SalePromotion.create!(
  amount: 10,
  type: 'flat_discount',
  sale: sale1
)
