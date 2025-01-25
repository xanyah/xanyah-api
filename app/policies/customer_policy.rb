# frozen_string_literal: true

class CustomerPolicy < Presets::UserEditablePolicy
  def permitted_attributes_for_create
    %i[firstname lastname email phone address notes store_id]
  end

  def permitted_attributes_for_update
    %i[firstname lastname email phone address notes]
  end
end
