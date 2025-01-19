# frozen_string_literal: true

class InventoryVariantPolicy < Presets::UserEditablePolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.includes(:inventory).where(inventory: { store_id: user.store_ids })
    end
  end

  def permitted_attributes_for_create
    %i[quantity inventory_id variant_id]
  end

  def permitted_attributes_for_update
    %i[quantity]
  end
end
