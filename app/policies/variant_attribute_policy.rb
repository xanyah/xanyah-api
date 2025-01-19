# frozen_string_literal: true

class VariantAttributePolicy < Presets::UserEditablePolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.includes(:product).where(product: { store_id: user.store_ids })
    end
  end

  def permitted_attributes_for_create
    %i[
      custom_attribute_id
      variant_id
      value
    ]
  end

  def permitted_attributes_for_update
    %i[
      value
    ]
  end
end
