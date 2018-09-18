# frozen_string_literal: true

module StockBackupAbility
  def stock_backup_ability(user)
    can :read, StockBackup do |stock_backup|
      stock_backup.store.users.include?(user)
    end
    can :manage, StockBackup do |stock_backup|
      stock_backup.store.admins.include?(user)
    end
  end
end
