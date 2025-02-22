# frozen_string_literal: true

class CategoryPolicy < Presets::AdminEditablePolicy
  def permitted_attributes_for_create
    %i[name store_id category_id]
  end

  def permitted_attributes_for_update
    %i[name category_id]
  end
end
