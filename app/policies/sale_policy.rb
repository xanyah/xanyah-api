# frozen_string_literal: true

class SalePolicy < Presets::UserEditablePolicy
  def permitted_attributes_for_create
    [
      :store_id,
      :customer_id,
      :total_amount_cents,
      :total_amount_currency,
      { sale_products_attributes: %i[
          product_id
          quantity
          amount_cents
          amount_currency
          original_amount_cents
          original_amount_currency
        ],
        sale_payments_attributes: %i[
          payment_type_id
          total_amount_cents
          total_amount_currency
        ],
        sale_promotion_attributes: %i[type amount_cents amount_currency] }
    ]
  end

  def permitted_attributes_for_update
    %i[]
  end
end