module InventoryVariantAbility
  def inventory_variant_ability(user)
    can :crud, InventoryVariant do |iv|
      !iv.inventory_id.nil? &&
      iv.inventory.locked_at.nil? &&
      !iv.inventory.store_id.nil? &&
      iv.inventory.store.users.include?(user)
    end
  end
end
