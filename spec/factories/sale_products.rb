# frozen_string_literal: true

FactoryBot.define do
  factory :sale_product do
    sale
    product { build(:product, store: sale.store) }

    amount { product.amount }
  end
end
