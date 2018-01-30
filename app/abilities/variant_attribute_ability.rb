module VariantAttributeAbility
  def variant_attribute_ability(user)
    can :manage, VariantAttribute do |va|
       !va.variant_id.nil? && va.variant.store.users.include?(user)
    end
  end
end
