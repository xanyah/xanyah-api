# frozen_string_literal: true

class Inventory < ApplicationRecord
  belongs_to :store, optional: false
  has_many :inventory_products, dependent: :destroy

  def lock
    update(locked_at: Time.current)
  end
end
