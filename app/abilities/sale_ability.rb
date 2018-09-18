# frozen_string_literal: true

module SaleAbility
  def sale_ability(user)
    can :manage, Sale do |sale|
      !sale.store_id.nil? && sale.store.users.include?(user)
    end
  end
end
