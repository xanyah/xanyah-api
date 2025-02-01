# frozen_string_literal: true

class SalePaymentPolicy < Presets::UserEditablePolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(sale: SalePolicy::Scope.new(user, Sale).resolve)
    end
  end
end
