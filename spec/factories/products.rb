FactoryBot.define do
  factory :product do
    name {Faker::Beer.name}

    store

    category {build(:category, store: store)}
    manufacturer {build(:manufacturer, store: store)}
  end
end
