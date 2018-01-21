FactoryBot.define do
  factory :category do
    label "Category label"
    tva :standard_rate
    store
  end
end
