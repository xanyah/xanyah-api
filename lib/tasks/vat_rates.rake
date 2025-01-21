# frozen_string_literal: true

require 'net/http'

namespace :vat_rates do
  desc 'Update VAT rates from https://euvat.ga/'
  task import: :environment do
    response = Net::HTTP.get(URI("https://apilayer.net/api/rate_list?access_key=#{ENV.fetch('VAT_LAYER_API_KEY', nil)}"))
    response = JSON.parse(response)
    rates = response['rates']

    rates.each do |country_code, data|
      country = Country.where(code: country_code).first_or_create do |pending_country|
        pending_country.name = data['country_name']
      end

      VatRate.where(country:, rate_percent_cents: (data['standard_rate'] * 100).to_i).first_or_create!

      data['reduced_rates'].each_value do |value|
        VatRate.where(country:, rate_percent_cents: (value * 100).to_i).first_or_create!
      end
    end
  end
end
