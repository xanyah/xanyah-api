# frozen_string_literal: true

class Country < ApplicationRecord
  has_many :vat_rates, dependent: :destroy
end
