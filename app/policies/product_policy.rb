# frozen_string_literal: true

class ProductPolicy < Presets::UserEditablePolicy
  def permitted_attributes_for_create
    [
      :name,
      :category_id,
      :manufacturer_id,
      :store_id,
      { variants_attributes: %i[
        buying_amount_cents
        buying_amount_currency
        original_barcode
        tax_free_amount_cents
        tax_free_amount_currency
        provider_id
        ratio
      ] }
    ]
  end

  def permitted_attributes_for_update
    [
      :name,
      :category_id,
      :manufacturer_id,
      { variants_attributes: %i[
        id
        buying_price
        original_barcode
        tax_free_price
        provider_id
        ratio
        _destroy
      ] }
    ]
  end
end
