# frozen_string_literal: true

class ProductPolicy < Presets::UserEditablePolicy
  def permitted_attributes_for_create
    %i[
      name
      category_id
      manufacturer_id
      store_id
      amount
      amount_cents
      amount_currency
      buying_amount
      buying_amount_cents
      buying_amount_currency
      tax_free_amount
      tax_free_amount_cents
      tax_free_amount_currency
      sku
      upc
      manufacturer_sku
    ]
  end

  def permitted_attributes_for_update
    %i[
      name
      category_id
      manufacturer_id
      amount
      amount_cents
      amount_currency
      buying_amount
      buying_amount_cents
      buying_amount_currency
      tax_free_amount
      tax_free_amount_cents
      tax_free_amount_currency
      sku
      upc
      manufacturer_sku
    ]
  end
end
