# frozen_string_literal: true

class ShippingPolicy < Presets::UserEditablePolicy
  alias lock? store_user?

  def permitted_attributes_for_create
    %i[store_id provider_id]
  end

  def permitted_attributes_for_update
    []
  end
end
