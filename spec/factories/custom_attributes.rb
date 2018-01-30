FactoryBot.define do
  factory :custom_attribute do
    name {Faker::Beer.hop}
    type {%w(text number).sample}
    store
  end
end
