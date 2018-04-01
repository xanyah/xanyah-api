# frozen_string_literal: true

module ClientAbility
  def client_ability(user)
    can :cru, Client do |client|
      !client.store_id.nil? && client.store.users.include?(user)
    end
  end
end
