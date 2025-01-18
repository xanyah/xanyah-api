# frozen_string_literal: true

FactoryBot.define do
  factory :sale_payment do
    total { Faker::Number.decimal(l_digits: 2) }
    sale
    payment_type { build(:payment_type, store: sale&.store) }
  end
end
