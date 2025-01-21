# frozen_string_literal: true

class VatRateSerializer < ActiveModel::Serializer
  attributes :id,
             :rate_percent_cents

  belongs_to :country
end
