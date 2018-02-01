# frozen_string_literal: true

module ProviderAbility
  def provider_ability(user)
    can :cru, Provider do |provider|
      !provider.store_id.nil? && provider.store.users.include?(user)
    end
  end
end
