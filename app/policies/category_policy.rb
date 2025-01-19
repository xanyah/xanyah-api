# frozen_string_literal: true

class CategoryPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(store_id: user.store_ids)
    end
  end

  def show?
    user.store_user?(record.store)
  end

  def create?
    user.store_admin?(record.store)
  end

  def update?
    user.store_admin?(record.store)
  end

  def destroy?
    user.store_admin?(record.store)
  end

  def permitted_attributes_for_create
    %i[name tva store_id category_id]
  end

  def permitted_attributes_for_update
    %i[name category_id]
  end
end
