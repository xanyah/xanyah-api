# frozen_string_literal: true

FactoryBot.define do
  factory :inventory_product do
    inventory
    product { build(:product, store: inventory.store) }
    quantity { rand(1..25) }
  end
end
