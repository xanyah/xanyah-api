# frozen_string_literal: true

module CustomAttributeAbility
  def custom_attribute_ability(user)
    can :manage, CustomAttribute do |ca|
      !ca.store_id.nil? && ca.store.users.include?(user)
    end
  end
end
