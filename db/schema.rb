# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180605123201) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.integer "tva"
    t.uuid "store_id"
    t.uuid "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_categories_on_category_id"
    t.index ["store_id"], name: "index_categories_on_store_id"
  end

  create_table "clients", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.string "phone"
    t.string "address"
    t.text "notes"
    t.uuid "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_clients_on_store_id"
  end

  create_table "custom_attributes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.integer "type"
    t.uuid "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_custom_attributes_on_store_id"
  end

  create_table "inventories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "locked_at"
    t.uuid "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_inventories_on_store_id"
  end

  create_table "inventory_variants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "quantity"
    t.uuid "inventory_id"
    t.uuid "variant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inventory_id"], name: "index_inventory_variants_on_inventory_id"
    t.index ["variant_id"], name: "index_inventory_variants_on_variant_id"
  end

  create_table "manufacturers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "notes"
    t.uuid "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_manufacturers_on_store_id"
  end

  create_table "order_variants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "variant_id"
    t.uuid "order_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_variants_on_order_id"
    t.index ["variant_id"], name: "index_order_variants_on_variant_id"
  end

  create_table "orders", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "status", default: 0
    t.uuid "client_id"
    t.uuid "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_orders_on_client_id"
    t.index ["store_id"], name: "index_orders_on_store_id"
  end

  create_table "payment_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.uuid "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_payment_types_on_store_id"
  end

  create_table "plans", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "gateway_id"
    t.integer "monthly_price_cents", default: 0, null: false
    t.string "monthly_price_currency", default: "EUR", null: false
    t.integer "yearly_price_cents", default: 0, null: false
    t.string "yearly_price_currency", default: "EUR", null: false
    t.integer "status"
    t.integer "max_users"
    t.integer "max_variants"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "category_id"
    t.uuid "manufacturer_id"
    t.uuid "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["manufacturer_id"], name: "index_products_on_manufacturer_id"
    t.index ["store_id"], name: "index_products_on_store_id"
  end

  create_table "providers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "notes"
    t.uuid "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_providers_on_store_id"
  end

  create_table "sale_payments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.float "total"
    t.uuid "payment_type_id"
    t.uuid "sale_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payment_type_id"], name: "index_sale_payments_on_payment_type_id"
    t.index ["sale_id"], name: "index_sale_payments_on_sale_id"
  end

  create_table "sale_promotions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "type"
    t.float "amount"
    t.uuid "sale_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sale_id"], name: "index_sale_promotions_on_sale_id"
  end

  create_table "sale_variant_promotions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "type"
    t.float "amount"
    t.uuid "sale_variant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sale_variant_id"], name: "index_sale_variant_promotions_on_sale_variant_id"
  end

  create_table "sale_variants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "quantity"
    t.float "unit_price"
    t.uuid "sale_id"
    t.uuid "variant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sale_id"], name: "index_sale_variants_on_sale_id"
    t.index ["variant_id"], name: "index_sale_variants_on_variant_id"
  end

  create_table "sales", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.boolean "completed", default: false
    t.float "total_price"
    t.uuid "client_id"
    t.uuid "store_id"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_sales_on_client_id"
    t.index ["store_id"], name: "index_sales_on_store_id"
    t.index ["user_id"], name: "index_sales_on_user_id"
  end

  create_table "shipping_variants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "quantity"
    t.uuid "shipping_id"
    t.uuid "variant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shipping_id"], name: "index_shipping_variants_on_shipping_id"
    t.index ["variant_id"], name: "index_shipping_variants_on_variant_id"
  end

  create_table "shippings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "locked_at"
    t.uuid "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "provider_id"
    t.index ["provider_id"], name: "index_shippings_on_provider_id"
    t.index ["store_id"], name: "index_shippings_on_store_id"
  end

  create_table "stock_backup_variants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "quantity"
    t.uuid "stock_backup_id"
    t.uuid "variant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_backup_id"], name: "index_stock_backup_variants_on_stock_backup_id"
    t.index ["variant_id"], name: "index_stock_backup_variants_on_variant_id"
  end

  create_table "stock_backups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_stock_backups_on_store_id"
  end

  create_table "store_memberships", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id"
    t.uuid "user_id"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_store_memberships_on_store_id"
    t.index ["user_id"], name: "index_store_memberships_on_user_id"
  end

  create_table "stores", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key"
    t.string "name"
    t.string "address"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "gateway_customer_id"
  end

  create_table "subscriptions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id"
    t.uuid "plan_id"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.integer "status"
    t.string "payment_gateway"
    t.string "payment_gateway_subscription_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_subscriptions_on_plan_id"
    t.index ["store_id"], name: "index_subscriptions_on_store_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "firstname"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "lastname"
    t.string "locale", default: "en"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "variant_attributes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "value"
    t.uuid "variant_id"
    t.uuid "custom_attribute_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["custom_attribute_id"], name: "index_variant_attributes_on_custom_attribute_id"
    t.index ["variant_id"], name: "index_variant_attributes_on_variant_id"
  end

  create_table "variants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "original_barcode"
    t.string "barcode"
    t.float "buying_price", default: 0.0
    t.float "tax_free_price", default: 0.0
    t.float "ratio", default: 0.0
    t.integer "quantity", default: 0
    t.boolean "default"
    t.uuid "product_id"
    t.uuid "provider_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_variants_on_product_id"
    t.index ["provider_id"], name: "index_variants_on_provider_id"
  end

  create_table "vat_rates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "country_code"
    t.string "country_name"
    t.float "standard_rate"
    t.float "reduced_rate"
    t.float "reduced_rate_alt"
    t.float "super_reduced_rate"
    t.float "parking_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "categories", "categories"
  add_foreign_key "categories", "stores"
  add_foreign_key "clients", "stores"
  add_foreign_key "custom_attributes", "stores"
  add_foreign_key "inventories", "stores"
  add_foreign_key "inventory_variants", "inventories"
  add_foreign_key "inventory_variants", "variants"
  add_foreign_key "manufacturers", "stores"
  add_foreign_key "order_variants", "orders"
  add_foreign_key "order_variants", "variants"
  add_foreign_key "orders", "clients"
  add_foreign_key "orders", "stores"
  add_foreign_key "payment_types", "stores"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "manufacturers"
  add_foreign_key "products", "stores"
  add_foreign_key "providers", "stores"
  add_foreign_key "sale_payments", "payment_types"
  add_foreign_key "sale_payments", "sales"
  add_foreign_key "sale_promotions", "sales"
  add_foreign_key "sale_variant_promotions", "sale_variants"
  add_foreign_key "sale_variants", "sales"
  add_foreign_key "sale_variants", "variants"
  add_foreign_key "sales", "clients"
  add_foreign_key "sales", "stores"
  add_foreign_key "sales", "users"
  add_foreign_key "shipping_variants", "shippings"
  add_foreign_key "shipping_variants", "variants"
  add_foreign_key "shippings", "stores"
  add_foreign_key "stock_backup_variants", "stock_backups"
  add_foreign_key "stock_backup_variants", "variants"
  add_foreign_key "stock_backups", "stores"
  add_foreign_key "store_memberships", "stores"
  add_foreign_key "store_memberships", "users"
  add_foreign_key "subscriptions", "plans"
  add_foreign_key "subscriptions", "stores"
  add_foreign_key "variant_attributes", "custom_attributes"
  add_foreign_key "variant_attributes", "variants"
  add_foreign_key "variants", "products"
  add_foreign_key "variants", "providers"
end
