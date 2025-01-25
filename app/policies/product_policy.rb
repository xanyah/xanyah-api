# frozen_string_literal: true

class ProductPolicy < Presets::UserEditablePolicy
  def permitted_attributes_for_create
    %i[
      name
      category_id
      manufacturer_id
      store_id
      buying_amount_cents
      buying_amount_currency
      tax_free_amount_cents
      tax_free_amount_currency
      provider_id
      sku
      upc
    ]
  end

  def permitted_attributes_for_update
    %i[
      name
      category_id
      manufacturer_id
      buying_amount_cents
      buying_amount_currency
      tax_free_amount_cents
      tax_free_amount_currency
      provider_id
      sku
      upc
    ]
  end
end
