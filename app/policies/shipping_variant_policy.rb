# frozen_string_literal: true

class ShippingVariantPolicy < Presets::UserEditablePolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.includes(:shipping).where(shipping: { store_id: user.store_ids })
    end
  end

  def permitted_attributes_for_create
    %i[quantity shipping_id variant_id]
  end

  def permitted_attributes_for_update
    [:quantity]
  end
end
