# frozen_string_literal: true

class CountryPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end
end
