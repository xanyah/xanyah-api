# frozen_string_literal: true

FactoryBot.define do
  factory :inventory_product do
    inventory
    product
    quantity { rand(1..25) }
  end
end
