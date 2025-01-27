# frozen_string_literal: true

module CustomerAbility
  def customer_ability(user)
    can :manage, Customer do |customer|
      !customer.store_id.nil? && customer.store.users.include?(user)
    end
  end
end
