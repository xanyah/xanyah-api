# frozen_string_literal: true

module ShippingVariantAbility
  def shipping_variant_ability(user)
    can :manage, ShippingVariant do |iv|
      !iv.shipping_id.nil? &&
      iv.shipping.locked_at.nil? &&
      !iv.shipping.store_id.nil? &&
      iv.shipping.store.users.include?(user)
    end
    can :read, ShippingVariant do |iv|
      !iv.shipping.store_id.nil? && iv.shipping.store.users.include?(user)
    end
  end
end
