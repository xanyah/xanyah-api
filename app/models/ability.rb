class Ability
  include CanCan::Ability
  include StoreAbility

  def initialize(user)
    user ||= User.new

    store_ability user
  end
end
