# frozen_string_literal: true

class PaymentTypePolicy < Presets::AdminEditablePolicy
  def permitted_attributes_for_create
    %i[name description store_id]
  end

  def permitted_attributes_for_update
    %i[name description]
  end
end
