# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def store_admin?
    user.store_admin?(record.store)
  end

  def store_user?
    user.store_user?(record.store)
  end

  alias show? store_user?
  alias create? store_admin?
  alias update? store_admin?
  alias destroy? store_admin?

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.where(store_id: user.store_ids)
    end

    private

    attr_reader :user, :scope
  end
end
