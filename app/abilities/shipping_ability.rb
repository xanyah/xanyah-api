# frozen_string_literal: true

module ShippingAbility
  def shipping_ability(user)
    can :read, Shipping do |shipping|
      !shipping.store_id.nil? && shipping.store.users.include?(user)
    end
    can [:create, :lock], Shipping do |shipping|
      !shipping.store_id.nil? && shipping.store.admins.include?(user)
    end
    can :destroy, Shipping do |shipping|
      shipping.locked_at.nil? && shipping.store.admins.include?(user)
    end
  end
end
