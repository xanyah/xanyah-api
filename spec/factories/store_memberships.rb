FactoryBot.define do
  factory :store_membership do
    store
    user
    role :regular
  end
end
