# frozen_string_literal: true

module StoreAbility
  def store_ability(user)
    can :create, Store
    can :read, Store do |store|
      store.users.include?(user)
    end
    can :update, Store do |store|
      store.admins.include?(user)
    end
  end
end
