# frozen_string_literal: true

class ManufacturerPolicy < Presets::UserEditablePolicy
  def permitted_attributes_for_create
    %i[name notes store_id]
  end

  def permitted_attributes_for_update
    %i[name notes]
  end
end
