# frozen_string_literal: true

FactoryBot.define do
  factory :store_membership do
    store
    user
    role { %w[regular admin owner].sample }
  end
end
