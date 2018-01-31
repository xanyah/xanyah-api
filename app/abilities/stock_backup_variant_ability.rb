module StockBackupVariantAbility
  def stock_backup_variant_ability(user)
    can :read, StockBackupVariant do |stock_backup_variant|
      stock_backup_variant.stock_backup.store.users.include?(user)
    end
  end
end
