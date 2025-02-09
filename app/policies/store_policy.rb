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
    %i[
      name
      address1
      address2
      zipcode
      phone_number
      website_url
      email_address
      country_id
      color
      city
      key
    ]
  end

  def permitted_attributes_for_update
    %i[
      name
      address1
      address2
      zipcode
      phone_number
      website_url
      email_address
      color
      city
    ]
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      user.stores
    end
  end
end
