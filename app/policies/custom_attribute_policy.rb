# frozen_string_literal: true

class CustomAttributePolicy < Presets::AdminEditablePolicy
  def permitted_attributes_for_create
    %i[name type store_id]
  end

  def permitted_attributes_for_update
    %i[name type]
  end
end
