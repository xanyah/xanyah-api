# frozen_string_literal: true

class StoreMembershipPolicy < Presets::AdminEditablePolicy
  def permitted_attributes_for_create
    %i[store_id user_id role]
  end

  def permitted_attributes_for_update
    [:role]
  end
end
