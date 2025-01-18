# frozen_string_literal: true

module InventoryAbility
  def inventory_ability(user) # rubocop:disable Metrics/AbcSize
    can :read, Inventory do |inventory|
      !inventory.store_id.nil? && inventory.store.users.include?(user)
    end
    can [:create, :lock], Inventory do |inventory|
      !inventory.store_id.nil? && inventory.store.admins.include?(user)
    end
    can :destroy, Inventory do |inventory|
      inventory.locked_at.nil? && inventory.store.admins.include?(user)
    end
  end
end
