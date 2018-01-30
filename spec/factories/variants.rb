FactoryBot.define do
  factory :variant do
    original_barcode {Faker::Number.number(10).to_s}
    buying_price {Faker::Number.decimal(2)}
    tax_free_price {"#{buying_price}".to_f * 1.8}
    provider
    product
    default false
    ratio {Faker::Number.decimal(2)}
  end
end
