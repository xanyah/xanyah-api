# frozen_string_literal: true

class VariantPolicy < Presets::UserEditablePolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.includes(:product).where(product: { store_id: user.store_ids })
    end
  end

  def permitted_attributes_for_create
    [
      :original_barcode,
      :buying_price,
      :tax_free_price,
      :ratio,
      :product_id,
      :provider_id,
      :default,
      { variant_attributes_attributes: %i[
        value
        custom_attribute_id
      ] }
    ]
  end

  def permitted_attributes_for_update
    [
      :buying_price,
      :tax_free_price,
      :ratio,
      :default,
      { variant_attributes_attributes: %i[
        _destroy
        id
        value
        custom_attribute_id
      ] }
    ]
  end
end
