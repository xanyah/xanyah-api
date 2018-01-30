FactoryBot.define do
  factory :variant_attribute do
    value {Faker::Beer.malts}
    custom_attribute
    variant
  end
end
