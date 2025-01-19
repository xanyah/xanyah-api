# frozen_string_literal: true

class SalePolicy < Presets::UserEditablePolicy
  def permitted_attributes_for_create
    [
      :store_id,
      :client_id,
      :total_price,
      { sale_variants_attributes: [
          :variant_id,
          :quantity,
          { sale_variant_promotion_attributes: %i[type amount] }
        ],
        sale_payments_attributes: %i[
          payment_type_id
          total
        ],
        sale_promotion_attributes: %i[type amount] }
    ]
  end

  def permitted_attributes_for_update
    %i[]
  end
end
