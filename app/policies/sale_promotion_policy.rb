# frozen_string_literal: true

class SalePromotionPolicy < Presets::UserEditablePolicy
  def permitted_attributes_for_create
    %i[type amount sale_id]
  end

  def permitted_attributes_for_update
    %i[type amount]
  end
end
