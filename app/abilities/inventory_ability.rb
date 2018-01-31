# frozen_string_literal: true

module InventoryAbility
  def inventory_ability(user)
    can :read, Inventory do |inventory|
      !inventory.store_id.nil? && inventory.store.users.include?(user)
    end
    can [:create, :lock], Inventory do |inventory|
      !inventory.store_id.nil? && inventory.store.admins.include?(user)
    end
  end
end
