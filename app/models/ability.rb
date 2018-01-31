class Ability
  include CanCan::Ability

  include CategoryAbility
  include CustomAttributeAbility
  include InventoryAbility
  include InventoryVariantAbility
  include ManufacturerAbility
  include ProductAbility
  include ProviderAbility
  include StockBackupAbility
  include StockBackupVariantAbility
  include StoreAbility
  include StoreMembershipAbility
  include VariantAbility
  include VariantAttributeAbility

  def initialize(user)
    user ||= User.new

    alias_action :create, :read, :update, to: :cru
    alias_action :create, :read, :update, :destroy, to: :crud

    category_ability user
    custom_attribute_ability user
    inventory_ability user
    inventory_variant_ability user
    manufacturer_ability user
    product_ability user
    provider_ability user
    stock_backup_ability user
    stock_backup_variant_ability user
    store_ability user
    store_membership_ability user
    variant_ability user
    variant_attribute_ability user
  end
end
