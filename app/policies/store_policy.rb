# frozen_string_literal: true

class StorePolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    user.store_owner?(record)
  end

  def update?
    user.store_admin?(record)
  end

  def show?
    user.store_user?(record)
  end

  def permitted_attributes_for_create
    %i[name address country_id key]
  end

  def permitted_attributes_for_update
    %i[name address]
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      user.stores
    end
  end
end
