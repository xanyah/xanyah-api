# frozen_string_literal: true

class SalePolicy < Presets::UserEditablePolicy
  def permitted_attributes_for_create
    [
      :store_id,
      :client_id,
      :total_amount_cents,
      :total_amount_currency,
      { sale_variants_attributes: [
          :variant_id,
          :quantity,
          { sale_variant_promotion_attributes: %i[type amount_cents amount_currency] }
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
