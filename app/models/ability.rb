# frozen_string_literal: true

class Ability
  include CanCan::Ability

  include CategoryAbility
  include CustomerAbility
  include CustomAttributeAbility
  include InventoryAbility
  include ManufacturerAbility
  include OrderAbility
  include PaymentTypeAbility
  include ProductAbility
  include ProviderAbility
  include SaleAbility
  include ShippingAbility
  include StoreAbility
  include StoreMembershipAbility

  def initialize(user)
    user ||= User.new

    category_ability user
    customer_ability user
    custom_attribute_ability user
    inventory_ability user
    manufacturer_ability user
    order_ability user
    payment_type_ability user
    product_ability user
    provider_ability user
    sale_ability user
    shipping_ability user
    store_ability user
    store_membership_ability user
  end
end
