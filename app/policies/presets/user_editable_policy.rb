# frozen_string_literal: true

module Presets
  class UserEditablePolicy < ApplicationPolicy
    class Scope < ApplicationPolicy::Scope
      def resolve
        scope.where(store_id: user.store_ids)
      end
    end

    alias show? store_user?
    alias create? store_user?
    alias update? store_user?
    alias destroy? store_user?
  end
end
