# frozen_string_literal: true

class OrderPolicy < Presets::UserEditablePolicy
  def permitted_attributes_for_create
    [
      :client_id,
      :store_id,
      { order_variants_attributes: %i[variant_id quantity amount_cents amount_currency] }
    ]
  end

  def permitted_attributes_for_update
    %i[]
  end
end
