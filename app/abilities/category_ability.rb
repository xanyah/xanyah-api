# frozen_string_literal: true

module CategoryAbility
  def category_ability(user)
    can :manage, Category do |category|
      !category.store_id.nil? && category.store.users.include?(user)
    end
  end
end
