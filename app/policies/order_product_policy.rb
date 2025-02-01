# frozen_string_literal: true

class OrderProductPolicy < Presets::UserEditablePolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(order: OrderPolicy::Scope.new(user, Order).resolve)
    end
  end
end
