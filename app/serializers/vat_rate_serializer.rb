# frozen_string_literal: true

class VatRateSerializer < ActiveModel::Serializer
  attributes :id,
             :country_code,
             :country_name,
             :standard_rate,
             :reduced_rate,
             :reduced_rate_alt,
             :super_reduced_rate,
             :parking_rate
end
