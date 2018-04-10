# frozen_string_literal: true

class VatRate < ApplicationRecord
  validates :country_code, uniqueness: true
end
