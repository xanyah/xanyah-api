# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    sequence :name do |n|
      "#{Faker::Beer.style} #{n}"
    end
    tva { Category.tvas.keys.sample }
    store
  end
end
