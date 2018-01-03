class Ability
  include CanCan::Ability
  include StoreAbility

  def initialize(user)
    store_ability user
  end
end
