# frozen_string_literal: true

module ProductAbility
  def product_ability(user)
    can :manage, Product do |product|
      !product.store_id.nil? && product.store.users.include?(user)
    end
  end
end
