# frozen_string_literal: true

class ShippingProductPolicy < Presets::UserEditablePolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(shipping: ShippingPolicy::Scope.new(user, Shipping).resolve)
    end
  end
end
