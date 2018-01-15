FactoryBot.define do
  factory :manufacturer do
    name {Faker::StarWars.character}
    notes {Faker::Address.street_address}
    store
  end
end
