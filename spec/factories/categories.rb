FactoryBot.define do
  factory :category do
    name {Faker::Beer.style}
    tva {%w(standard_rate reduced_rate reduced_rate_alt super_reduced_rate parking_rate).sample}
    store
  end
end
