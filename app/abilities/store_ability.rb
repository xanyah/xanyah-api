module StoreAbility
  def store_ability(user)
    can :create, Store
    can :read, Store do |store|
      store.users.include?(user)
    end
    can :manage, Store do |store|
      store.admins.include?(user)
    end
    cannot :destroy, Store
  end
end
