# frozen_string_literal: true

FactoryBot.define do
  factory :custom_attribute do
    sequence :name do |n|
      "#{Faker::Beer.hop} #{n}"
    end
    type { %w[text number].sample }
    store
  end
end
