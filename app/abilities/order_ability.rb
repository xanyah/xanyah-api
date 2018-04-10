# frozen_string_literal: true

module OrderAbility
  def order_ability(user)
    can :crud, Order do |order|
      !order.store_id.nil? && order.store.users.include?(user)
    end
  end
end
