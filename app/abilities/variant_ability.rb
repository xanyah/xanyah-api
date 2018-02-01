# frozen_string_literal: true

module VariantAbility
  def variant_ability(user)
    can :cru, Variant do |variant|
      !variant.product.nil? && !variant.product.store_id.nil? && variant.product.store.users.include?(user)
    end
  end
end
