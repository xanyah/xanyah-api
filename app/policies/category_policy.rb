# frozen_string_literal: true

class CategoryPolicy < Presets::AdminEditablePolicy
  def permitted_attributes_for_create
    %i[name vat_rate_id store_id category_id]
  end

  def permitted_attributes_for_update
    %i[name category_id vat_rate_id]
  end
end
