# frozen_string_literal: true

class InventoryPolicy < Presets::UserEditablePolicy
  alias lock? store_user?

  def permitted_attributes_for_create
    %i[store_id]
  end

  def permitted_attributes_for_update
    %i[]
  end
end
