module CategoryAbility
  def category_ability(user)
    can :cru, Category do |category|
       !category.store_id.nil? && category.store.users.include?(user)
    end
  end
end
