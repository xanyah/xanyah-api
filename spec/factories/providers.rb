FactoryBot.define do
  factory :provider do
    name {Faker::Company.name}
    notes {Faker::Address.street_address}
    store
  end
end
