# frozen_string_literal: true

class SaleProductPolicy < Presets::UserEditablePolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(sale: SalePolicy::Scope.new(user, Sale).resolve)
    end
  end
end
