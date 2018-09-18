# frozen_string_literal: true

class Ability
  include CanCan::Ability

  include CategoryAbility
  include ClientAbility
  include CustomAttributeAbility
  include InventoryAbility
  include InventoryVariantAbility
  include ManufacturerAbility
  include OrderAbility
  include PaymentTypeAbility
  include ProductAbility
  include ProviderAbility
  include SaleAbility
  include ShippingAbility
  include ShippingVariantAbility
  include StockBackupAbility
  include StockBackupVariantAbility
  include StoreAbility
  include StoreMembershipAbility
  include VariantAbility
  include VariantAttributeAbility

  def initialize(user)
    user ||= User.new

    category_ability user
    client_ability user
    custom_attribute_ability user
    inventory_ability user
    inventory_variant_ability user
    manufacturer_ability user
    order_ability user
    payment_type_ability user
    product_ability user
    provider_ability user
    sale_ability user
    shipping_ability user
    shipping_variant_ability user
    stock_backup_ability user
    stock_backup_variant_ability user
    store_ability user
    store_membership_ability user
    variant_ability user
    variant_attribute_ability user
  end
end
