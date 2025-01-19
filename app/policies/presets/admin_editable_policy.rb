# frozen_string_literal: true

module Presets
  class AdminEditablePolicy < ApplicationPolicy
    class Scope < ApplicationPolicy::Scope
      def resolve
        scope.where(store_id: user.store_ids)
      end
    end

    alias show? store_user?
    alias create? store_admin?
    alias update? store_admin?
    alias destroy? store_admin?
  end
end
