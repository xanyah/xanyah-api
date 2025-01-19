# frozen_string_literal: true

class StockBackupVariantPolicy < Presets::AdminEditablePolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.includes(:stock_backup).where(stock_backup: { store_id: user.store_ids })
    end
  end
end
