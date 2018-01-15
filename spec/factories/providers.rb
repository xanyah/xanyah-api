FactoryBot.define do
  factory :provider do
    name {Faker::RickAndMorty.character}
    notes {Faker::Address.street_address}
    store
  end
end
