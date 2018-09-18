# frozen_string_literal: true

module PaymentTypeAbility
  def payment_type_ability(user)
    can :manage, PaymentType do |payment_type|
      !payment_type.store_id.nil? && payment_type.store.users.include?(user)
    end
  end
end
