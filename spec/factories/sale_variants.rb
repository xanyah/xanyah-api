# frozen_string_literal: true

FactoryBot.define do
  factory :sale_variant do
    quantity { Faker::Number.number }
    unit_price { Faker::Number.decimal(2) }

    sale
    variant { build(:variant, store: sale&.store) }
  end
end
