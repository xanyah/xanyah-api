class Ability
  include CanCan::Ability
  
  include StoreAbility
  include StoreMembershipAbility

  def initialize(user)
    user ||= User.new

    alias_action :create, :read, :update, to: :cru

    store_ability user
    store_membership_ability user
  end
end
