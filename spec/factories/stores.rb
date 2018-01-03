FactoryBot.define do
  factory :store do
    key {Faker::Internet.domain_word}
    name {Faker::Company.name}
    address {Faker::Address.street_address}
    country {Faker::Address.country_code}
  end
end
