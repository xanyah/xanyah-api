# frozen_string_literal: true

module StoreMembershipAbility
  def store_membership_ability(user)
    can :cru, StoreMembership do |store_membership|
      store_membership.store.admins.include?(user) && !store_membership.owner?
    end
    can :read, StoreMembership do |store_membership|
      store_membership.store.users.include?(user)
    end
    can :destroy, StoreMembership do |store_membership|
      !store_membership.owner? && store_membership.store.admins.include?(user)
    end
  end
end
