# frozen_string_literal: true

class OrderPolicy < Presets::UserEditablePolicy
  def permitted_attributes_for_create
    [
      :customer_id,
      :store_id,
      { order_products_attributes: %i[product_id quantity amount_cents amount_currency] }
    ]
  end

  def permitted_attributes_for_update
    %i[]
  end
end
