# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    sequence :name do |n|
      "#{Faker::Beer.style} #{n}"
    end
    vat_rate { VatRate.first }
    store
  end
end
